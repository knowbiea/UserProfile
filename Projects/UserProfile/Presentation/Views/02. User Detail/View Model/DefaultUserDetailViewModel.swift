//
//  UserDetailViewModel.swift
//  UserProfile
//
//  Created by Arvind on 31/05/24.
//

import SwiftUI

protocol UserDetailViewModelInput {
    var user: UserDetail? { get }
    var viewState: ViewState { get }
}

protocol UserDetailViewModelOutput {
    func getUserDetail()
    func fetchUserDetail()
}

protocol UserDetailViewModel: UserDetailViewModelInput, UserDetailViewModelOutput { }

final class DefaultUserDetailViewModel: ObservableObject, UserDetailViewModel {
    
    // MARK: - Properties
    private var userID: Int
    private var userDetailUseCase: UserDetailUseCase
    private var userDetailTask: Cancellable? { willSet { userDetailTask?.cancel() } }
    var unavailableType: ContentUnavailableType = .userDetail
    @Published private(set) var user: UserDetail?
    @Published private(set) var viewState: ViewState = .idle
    
    var isLoading: Bool {
        viewState == .loading
    }
    
    // MARK: - Initialisers
    init(userID: Int,
         userDetailUseCase: UserDetailUseCase) {
        self.userID = userID
        self.userDetailUseCase = userDetailUseCase
    }
    
    private func fetchUserDetail() async throws -> UserDetail {
        return try await userDetailUseCase.execute(userID: userID)
    }
    
    @MainActor
    func getUserDetail() {
        Task {
            do {
                viewState = .loading
                user = try await fetchUserDetail()
                viewState = .loaded
                
            } catch {
                DLog("Error: \(error)")
                viewState = .error
                
            }
        }
    }
    
    func fetchUserDetail() {
        viewState = .loading
        userDetailTask = userDetailUseCase.execute(userID: userID, completion: { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    DLog("User Detail: \(user)")
                    self.user = user
                    self.viewState = .loaded
                    
                case .failure(let error):
                    DLog("Error: \(error.localizedDescription)")
                    self.viewState = .error
                    
                }
            }
        })
    }
}
