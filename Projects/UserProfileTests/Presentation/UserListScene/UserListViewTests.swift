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
    
    var path: URL!
    
    override func setUp() {
        super.setUp()
        path = getImageFromBundle(resource: "sample", withExtension: "jpg")
    }
    
    override func tearDown() {
        path = nil
        super.tearDown()
    }
    
    func testUserListView_displayUserListUnavailableView() {
        let userListView = UserContentUnavailableView(type: .userList)
        
        userListView.toVC.performSnapshotTest(named: "UserListContentUnavailable",
                                              testName: "UserList")
    }
    
    func testUserListView_displayUserListView() {
        let userListContentView = UserListContentView(users: [UserDTO.stub(image: path.absoluteString).toDomain()])
        
        userListContentView.toVC.performSnapshotTest(named: "UserListView",
                                              testName: "UserList")
    }
    
    func testUserListView_displayUserListCell() {
        let userListCell = UserListCell(user: UserDTO.stub(image: path.absoluteString).toDomain())
        
        userListCell.toVC.performSnapshotTest(named: "UserListCell",
                                              testName: "UserList")
    }
}
