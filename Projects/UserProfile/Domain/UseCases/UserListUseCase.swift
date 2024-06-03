//
//  UserListUseCase.swift
//  UserProfile
//
//  Created by Arvind on 31/05/24.
//

import Foundation

protocol UserListUseCase {
    func execute(completion: @escaping (Result<UserList, Error>) -> Void) -> Cancellable?
    func execute() async throws -> UserList
}

final class DefaultUserListUseCase: UserListUseCase {
    
    // MARK: - Properties
    private let userRepository: UserListRepository
    
    // MARK: - Initialisers
    init(userRepository: UserListRepository) {
        self.userRepository = userRepository
    }
    
    func execute(completion: @escaping (Result<UserList, Error>) -> Void) -> Cancellable? {
        return userRepository.fetchUserList { result in
            completion(result)
        }
    }
    
    func execute() async throws -> UserList {
        return try await userRepository.fetchUserList()
    }
}
