//
//  UserDetailViewModelTests.swift
//  UserProfileTests
//
//  Created by Arvind on 31/05/24.
//

import XCTest
@testable import UserProfile

final class UserDetailViewModelTests: XCTestCase {
    
    func testUserDetailViewModel_checkingFetchUserDetailIsSuccessful() {
        // given
        let repository = UserDetailRepositoryMock(userDetail: UserDetailDTO.stub().toDomain())
        let userCase = DefaultUserDetailUseCase(userDetailRepository: repository)
        let viewModel = DefaultUserDetailViewModel(userID: 1, userDetailUseCase: userCase)
        
        // when
        viewModel.fetchUserDetail()
        
        // then
        let expectation = XCTestExpectation(description: "delay")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertNotNil(viewModel.user, "User should not Empty")
            XCTAssertEqual(viewModel.user?.firstName, "Emily", "Users name doesn't match")
            XCTAssertTrue(viewModel.viewState == .loaded)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3)
        addTeardownBlock { [weak viewModel] in XCTAssertNil(viewModel) }
    }
    
    func testUserDetailViewModel_checkingFetchUserDetailIsFailure() {
        // given
        let repository = UserDetailRepositoryMock(error: UserDetailRepositoryMockError.failedFetching)
        let userCase = DefaultUserDetailUseCase(userDetailRepository: repository)
        let viewModel = DefaultUserDetailViewModel(userID: 1, userDetailUseCase: userCase)
        
        // when
        viewModel.fetchUserDetail()
        
        // then
        let expectation = XCTestExpectation(description: "delay")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertNil(viewModel.user, "User is Empty")
            XCTAssertFalse(viewModel.user?.firstName != nil, "User's firstname should empty or nil")
            XCTAssertTrue(viewModel.viewState == .error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3)
        addTeardownBlock { [weak viewModel] in XCTAssertNil(viewModel) }
    }
}
