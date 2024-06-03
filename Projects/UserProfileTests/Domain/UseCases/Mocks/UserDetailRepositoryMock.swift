//
//  UserDetailRepositoryMock.swift
//  UserProfileTests
//
//  Created by Arvind on 31/05/24.
//

import XCTest
@testable import UserProfile

enum UserDetailRepositoryMockError: Error {
    case failedFetching
}

final class UserDetailRepositoryMock: UserDetailRepository {
    
    let userDetail: UserDetail?
    let error: Error?
    
    init(userDetail: UserDetail? = nil,
         error: Error? = nil) {
        self.userDetail = userDetail
        self.error = error
    }
    
    func fetchUserDetail(userID: Int, completion: @escaping (Result<UserDetail, Error>) -> Void) -> Cancellable? {
        if let error {
            completion(.failure(error))
            
        } else if let userDetail {
            completion(.success(userDetail))
        }
        
        return nil
    }
    
    func fetchUserDetail(userID: Int) async throws -> UserDetail {
        if let error {
            throw error
            
        } else {
            return userDetail!
        }
    }
}
