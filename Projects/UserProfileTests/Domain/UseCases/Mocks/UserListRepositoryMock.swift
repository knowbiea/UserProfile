//
//  UserListRepositoryMock.swift
//  UserProfileTests
//
//  Created by Arvind on 31/05/24.
//

import XCTest
@testable import UserProfile

enum UserListRepositoryMockError: Error {
    case failedFetching
}

final class UserListRepositoryMock: UserListRepository {
    
    let userList: UserList?
    let error: Error?
    
    init(userList: UserList? = nil,
         error: Error? = nil) {
        self.userList = userList
        self.error = error
    }
    
    func fetchUserList(completion: @escaping (Result<UserList, Error>) -> Void) -> Cancellable? {
        if let error {
            completion(.failure(error))
            
        } else if let userList {
            completion(.success(userList))
        }
        
        return nil
    }
    
    func fetchUserList() async throws -> UserList {
        guard let userList else {
            throw error ?? UserListRepositoryMockError.failedFetching
        }
        
        return userList
    }
}

