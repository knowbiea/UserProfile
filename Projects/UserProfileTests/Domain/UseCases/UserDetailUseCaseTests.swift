//
//  UserDetailUseCaseTests.swift
//  UserProfileTests
//
//  Created by Arvind on 31/05/24.
//

import XCTest
@testable import UserProfile

final class UserDetailUseCaseTests: XCTestCase {
    
    // MARK: - Async Testing
    func testUserDetailUseCase_whenSuccessfullyFetchingUserDetailAsync() async {
        // given
        var userDetail: UserDetail?
        var failedError: Error?
        let userDetailRepositoryMock = UserDetailRepositoryMock(userDetail: UserDetailDTO.stub().toDomain())
        let useCase = DefaultUserDetailUseCase(userDetailRepository: userDetailRepositoryMock)
        
        // when
        do {
            userDetail = try await useCase.execute(userID: 1)
        } catch {
            failedError = error
        }
        
        // then
        XCTAssertNotNil(userDetail)
        XCTAssertNil(failedError)
    }

    func testUserDetailUseCase_whenFailedFetchingUserDetailAsync() async {
        // given
        var userDetail: UserDetail?
        var failedError: Error?
        let userDetailRepositoryMock = UserDetailRepositoryMock(error: UserDetailRepositoryMockError.failedFetching)
        let useCase = DefaultUserDetailUseCase(userDetailRepository: userDetailRepositoryMock)
        
        // when
        do {
            userDetail = try await useCase.execute(userID: 1)
        } catch {
            failedError = error
        }
        
        // then
        XCTAssertNil(userDetail)
        XCTAssertNotNil(failedError)
    }
}
