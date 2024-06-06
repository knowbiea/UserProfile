//
//  UserListViewTests.swift
//  UserProfileTests
//
//  Created by Arvind on 31/05/24.
//

import SwiftUI
import XCTest
@testable import UserProfile

class UserListViewTests: XCTestCase {
    
    func testUserListView_displayUserListUnavailableView() {
        let repository = UserListRepositoryMock(userList: UserListDTO.stub().toDomain())
        let userCase = DefaultUserListUseCase(userRepository: repository)
        let viewModel = DefaultUserListViewModel(userListUseCase: userCase)
        let userListView = UserListView(viewModel: viewModel).contentUnavailableView
        
        userListView.toVC.performSnapshotTest(named: "UserListContentUnavailable",
                                              testName: "UserList")
    }
    
    func testUserListView_displayUserListView() {
        let path = getImageFromBundle(resource: "sample", withExtension: "jpg")
        let repository = UserListRepositoryMock(userList: UserListDTO.stub().toDomain())
        let userCase = DefaultUserListUseCase(userRepository: repository)
        let viewModel = DefaultUserListViewModel(userListUseCase: userCase)
        let userListView = UserListView(viewModel: viewModel).userListView(users: UserListDTO.stub(users: [UserDTO.stub(image: path.absoluteString)]).toDomain().users ?? [])
        
        userListView.toVC.performSnapshotTest(named: "UserListView",
                                              testName: "UserList")
    }
    
    func testUserListView_displayUserListCell() {
        let path = getImageFromBundle(resource: "sample", withExtension: "jpg")
        let userListCell = UserListCell(user: UserDTO.stub(image: path.absoluteString).toDomain())
        
        userListCell.toVC.performSnapshotTest(named: "UserListCell",
                                              testName: "UserList")
    }
}
