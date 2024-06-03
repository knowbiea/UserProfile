//
//  UserDetailUseCase.swift
//  UserProfile
//
//  Created by Arvind on 31/05/24.
//

import Foundation

protocol UserDetailUseCase {
    func execute(userID: Int, completion: @escaping (Result<UserDetail, Error>) -> Void) -> Cancellable?
    func execute(userID: Int) async throws -> UserDetail
}

final class DefaultUserDetailUseCase: UserDetailUseCase {
    
    // MARK: - Properties
    private let userDetailRepository: UserDetailRepository
    
    // MARK: - Initialisers
    init(userDetailRepository: UserDetailRepository) {
        self.userDetailRepository = userDetailRepository
    }
    
    func execute(userID: Int, completion: @escaping (Result<UserDetail, Error>) -> Void) -> Cancellable? {
        return userDetailRepository.fetchUserDetail(userID: userID) { result in
            completion(result)
        }
    }
    
    func execute(userID: Int) async throws -> UserDetail {
        return try await userDetailRepository.fetchUserDetail(userID: userID)
    }
}
