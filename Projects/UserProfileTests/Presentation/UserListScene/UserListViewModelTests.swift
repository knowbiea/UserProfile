//
//  UserListViewModelTests.swift
//  UserProfileTests
//
//  Created by Arvind on 31/05/24.
//

import XCTest
@testable import UserProfile

final class UserListViewModelTests: XCTestCase {
    
    func testUserListViewModel_checkingFetchUserListIsSuccessful() async {
        // given
        let repository = UserListRepositoryMock(userList: UserListDTO.stub().toDomain())
        let userCase = DefaultUserListUseCase(userRepository: repository)
        let viewModel = DefaultUserListViewModel(userListUseCase: userCase)
        
        // when
        await viewModel.getUserList()
        
        // then
        sleep(2)
        XCTAssertNotNil(viewModel.users, "Users Array is Empty")
        XCTAssertEqual(viewModel.users.count, 1, "Users count doesn't match")
        XCTAssertEqual(viewModel.users.first?.firstName, "Emily", "Users name doesn't match")
        XCTAssertTrue(viewModel.viewState == .loaded)
        
        addTeardownBlock { [weak viewModel] in XCTAssertNil(viewModel) }
    }
    
    func testUserListViewModel_checkingFetchUserListIsFailure() async {
        // given
        let repository = UserListRepositoryMock(error: UserListRepositoryMockError.failedFetching)
        let userCase = DefaultUserListUseCase(userRepository: repository)
        let viewModel = DefaultUserListViewModel(userListUseCase: userCase)
        
        // when
        await viewModel.getUserList()
        
        // then
        sleep(2)
        XCTAssertNotNil(viewModel.users, "Users Array is Empty")
        XCTAssertEqual(viewModel.users.count, 0, "Users count doesn't match")
        XCTAssertFalse(viewModel.users.first?.firstName != nil, "Users name doesn't match")
        XCTAssertTrue(viewModel.viewState == .error)
        
        addTeardownBlock { [weak viewModel] in XCTAssertNil(viewModel) }
    }
    
    func testUserListViewModel_didSelectUser() async {
        // given
        let repository = UserListRepositoryMock(userList: UserListDTO.stub().toDomain())
        let userCase = DefaultUserListUseCase(userRepository: repository)
        let viewModel = DefaultUserListViewModel(userListUseCase: userCase)
        
        // when
        await viewModel.getUserList()
        
        // then
        sleep(2)
        XCTAssertNotNil(viewModel.users, "Users Array is Empty")
        XCTAssertEqual(viewModel.users.count, 1, "Users count doesn't match")
        XCTAssertEqual(viewModel.users.first?.firstName, "Emily", "Users name doesn't match")
        XCTAssertTrue(viewModel.viewState == .loaded)
        
        addTeardownBlock { [weak viewModel] in XCTAssertNil(viewModel) }
    }
}
