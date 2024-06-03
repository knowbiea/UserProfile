//
//  UserListViewModel.swift
//  UserProfile
//
//  Created by Arvind on 31/05/24.
//

import SwiftUI

struct UserListViewActions {
    var goToUserDetailScreen: (User) -> Void
}

protocol UserListViewModelInput {
    var users: [User] { get }
    var isLoading: Bool { get }
}

protocol UserListViewModelOutput {
    func goToUserDetailView(user: User)
    func getUserList()
    func fetchUserList()
}

protocol UserListViewModel: UserListViewModelInput, UserListViewModelOutput {}

final class DefaultUserListViewModel: ObservableObject, UserListViewModel {
    
    // MARK: - Properties
    @Published var hasAppeared = false
    @Published private(set) var users: [User] = []
    @Published private(set) var viewState: ViewState = .idle
    var unavailable: ContentUnavailableType = .userList
    private var actions: UserListViewActions?
    private var userListUseCase: UserListUseCase
    private var userListTask: Cancellable? { willSet { userListTask?.cancel() } }
    
    var isLoading: Bool {
        viewState == .loading
    }
    
    // MARK: - Intialisers
    init(userListUseCase: UserListUseCase, actions: UserListViewActions? = nil) {
        self.userListUseCase = userListUseCase
        self.actions = actions
    }
    
    func fetchUserList() {
        viewState = .loading
        userListTask = userListUseCase.execute { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let userList):
                    self.users = userList.users ?? []
                    self.viewState = .loaded
                case .failure(let error):
                    DLog("Error: \(error.localizedDescription)")
                    self.viewState = .error
                }
            }
        }
    }
    
    private func fetchUserList() async throws -> UserList {
        return try await userListUseCase.execute()
    }
    
    @MainActor
    func getUserList() {
        viewState = .loading
        Task {
            do {
                let userList = try await fetchUserList()
                users = userList.users ?? []
                viewState = .loaded
            } catch {
                DLog("Error: \(error)")
                viewState = .error
            }
        }
    }
    
    func goToUserDetailView(user: User) {
        actions?.goToUserDetailScreen(user)
    }
}
