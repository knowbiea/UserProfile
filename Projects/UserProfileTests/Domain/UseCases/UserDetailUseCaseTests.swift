//
//  UserDetailUseCaseTests.swift
//  UserProfileTests
//
//  Created by Arvind on 31/05/24.
//

import XCTest
@testable import UserProfile

final class UserDetailUseCaseTests: XCTestCase {
    
    func testUserDetailUseCase_whenSuccessfullyFetchingUserDetail() {
        // given
        var userDetail: UserDetail?
        let userDetailRepositoryMock = UserDetailRepositoryMock(userDetail: UserDetailDTO.stub().toDomain())
        let useCase = DefaultUserDetailUseCase(userDetailRepository: userDetailRepositoryMock)
        
        // when
        _ = useCase.execute(userID: 1, completion: { result in
            if case let .success(userDetailResult) = result {
                userDetail = userDetailResult
            }
        })
        
        // then
        XCTAssertTrue(userDetail != nil)
    }
    
//    func testUserDetailUseCase_whenSuccessfullyFetchingUserDetailWithEmptyUser() {
//        // given
//        var user: UserDetail?
//        let userDetailRepositoryMock = UserDetailRepositoryMock(userDetail: UserDetail(user: nil, support: nil))
//        let useCase = DefaultUserDetailUseCase(userDetailRepository: userDetailRepositoryMock)
//        
//        // when
//        _ = useCase.execute(userID: 1, completion: { result in
//            if case let .success(userDetailResult) = result {
//                user = userDetailResult.user
//            }
//        })
//        
//        // then
//        XCTAssertTrue(user == nil, "User is not Empty")
//    }

    func testUserDetailUseCase_whenFailedFetchingUserDetail() {
        // given
        var userDetail: UserDetail?
        var failedError: Error?
        let userDetailRepositoryMock = UserDetailRepositoryMock(error: UserDetailRepositoryMockError.failedFetching)
        let useCase = DefaultUserDetailUseCase(userDetailRepository: userDetailRepositoryMock)
        
        // when
        _ = useCase.execute(userID: 1, completion: { result in
            switch result {
            case .success(let user): userDetail = user
            case .failure(let error): failedError = error
            }
        })
        
        // then
        XCTAssertTrue(userDetail == nil)
        XCTAssertNotNil(failedError)
    }
    
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
    
//    func testUserDetailUseCase_whenSuccessfullyFetchingUserDetailWithEmptyUserAsync() async {
//        // given
//        var user: User?
//        var failedError: Error?
//        let userDetailRepositoryMock = UserDetailRepositoryMock(userDetail: UserDetail(user: nil, support: nil))
//        let useCase = DefaultUserDetailUseCase(userDetailRepository: userDetailRepositoryMock)
//        
//        // when
//        do {
//            let userDetail = try await useCase.execute(userID: 1)
//            user = userDetail.user
//        } catch {
//            failedError = error
//        }
//        
//        // then
//        XCTAssertNil(user, "User is not Empty")
//        XCTAssertNil(failedError)
//    }

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
