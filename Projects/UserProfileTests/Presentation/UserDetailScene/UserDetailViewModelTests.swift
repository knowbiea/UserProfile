//
//  UserDetailViewModelTests.swift
//  UserProfileTests
//
//  Created by Arvind on 31/05/24.
//

import XCTest
@testable import UserProfile

final class UserDetailViewModelTests: XCTestCase {
    
    func testUserDetailViewModel_checkingFetchUserDetailIsSuccessful() async {
        // given
        let repository = UserDetailRepositoryMock(userDetail: UserDetailDTO.stub().toDomain())
        let userCase = DefaultUserDetailUseCase(userDetailRepository: repository)
        let viewModel = DefaultUserDetailViewModel(userID: 1, userDetailUseCase: userCase)
        
        // when
        await viewModel.getUserDetail()
        
        // then
        sleep(2)
        XCTAssertNotNil(viewModel.user, "User should not Empty")
        XCTAssertEqual(viewModel.user?.firstName, "Emily", "Users name doesn't match")
        XCTAssertTrue(viewModel.viewState == .loaded)
        
        addTeardownBlock { [weak viewModel] in XCTAssertNil(viewModel) }
    }
    
    func testUserDetailViewModel_checkingFetchUserDetailIsFailure() async {
        // given
        let repository = UserDetailRepositoryMock(error: UserDetailRepositoryMockError.failedFetching)
        let userCase = DefaultUserDetailUseCase(userDetailRepository: repository)
        let viewModel = DefaultUserDetailViewModel(userID: 1, userDetailUseCase: userCase)
        
        // when
        await viewModel.getUserDetail()
        
        // then
        sleep(2)
        XCTAssertNil(viewModel.user, "User is Empty")
        XCTAssertFalse(viewModel.user?.firstName != nil, "User's firstname should empty or nil")
        XCTAssertTrue(viewModel.viewState == .error)
        
        addTeardownBlock { [weak viewModel] in XCTAssertNil(viewModel) }
    }
}
