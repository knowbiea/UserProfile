//
//  UserListUseCaseMock.swift
//  UserProfileTests
//
//  Created by Arvind on 07/06/24.
//

import XCTest
@testable import UserProfile

final class UserListUseCaseMock: UserListUseCase {
    
    let userList: UserList?
    let error: Error?
    
    init(userList: UserList? = nil,
         error: Error? = nil) {
        self.userList = userList
        self.error = error
    }
    
    func execute() async throws -> UserList {
        guard let userList else {
            throw error ?? UserListRepositoryMockError.failedFetching
        }
        
        return userList
    }
}
