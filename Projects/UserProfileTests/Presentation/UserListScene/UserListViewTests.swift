//
//  UserListViewTests.swift
//  UserProfileTests
//
//  Created by Arvind on 31/05/24.
//

import SwiftUI
import SnapshotTesting
import XCTest
@testable import UserProfile

class UserListViewTests: XCTestCase {
    
    func testUserListView_displayUserListUnavailableView() {
        let repository = UserListRepositoryMock(userList: UserListDTO.stub().toDomain())
        let userCase = DefaultUserListUseCase(userRepository: repository)
        let viewModel = DefaultUserListViewModel(userListUseCase: userCase)
        let userListView = UserListView(viewModel: viewModel).contentUnavailableView
        assertSnapshot(of: userListView.toVC, as: .image, named: "UserList", testName: "userListView_unavailable_test")
    }
    
    func testUserListView_displayUserListView() {
        
        let repository = UserListRepositoryMock(userList: UserListDTO.stub().toDomain())
        let userCase = DefaultUserListUseCase(userRepository: repository)
        let viewModel = DefaultUserListViewModel(userListUseCase: userCase)
        let userListView = UserListView(viewModel: viewModel).userListView(users: UserListDTO.stub().toDomain().users ?? [])

        assertSnapshot(of: userListView.toVC, as: .image, named: "UserListView", testName: "userListView_test")
    }
    
    func testUserListView_displayUserListCell() {
        let userListCell = UserListCell(user: UserDTO.stub().toDomain())
        assertSnapshot(of: userListCell.toVC, as: .image, named: "UserListCell", testName: "userListCell_test")
    }
}

extension SwiftUI.View {
    var toVC: UIViewController {
        let hostingController = UIHostingController(rootView: self)
        hostingController.view.frame = UIScreen.main.bounds
        return hostingController
    }
}
 
