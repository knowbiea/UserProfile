//
//  SwiftUIView.swift
//  UserProfileTests
//
//  Created by Arvind on 07/06/24.
//

import XCTest
@testable import UserProfile

final class UserDetailUseCaseMock: UserDetailUseCase {
    let userDetail: UserDetail?
    let error: Error?
    
    init(userDetail: UserDetail? = nil,
         error: Error? = nil) {
        self.userDetail = userDetail
        self.error = error
    }
    
    func execute(userID: Int) async throws -> UserDetail {
        guard let userDetail else {
            throw error ?? UserListRepositoryMockError.failedFetching
        }
        
        return userDetail
    }
}
