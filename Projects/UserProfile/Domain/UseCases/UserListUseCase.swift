//
//  UserListUseCase.swift
//  UserProfile
//
//  Created by Arvind on 31/05/24.
//

import Foundation

protocol UserListUseCase {
    func execute() async throws -> UserList
}

final class DefaultUserListUseCase: UserListUseCase {
    
    // MARK: - Properties
    private let userRepository: UserListRepository
    
    // MARK: - Initialisers
    init(userRepository: UserListRepository) {
        self.userRepository = userRepository
    }
    
    func execute() async throws -> UserList {
        return try await userRepository.fetchUserList()
    }
}
