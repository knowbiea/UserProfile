//
//  UserDetailViewTests.swift
//  UserProfileTests
//
//  Created by Arvind on 31/05/24.
//

import SwiftUI
import SnapshotTesting
import XCTest
@testable import UserProfile

class UserDetailViewTests: XCTestCase {
    
    func testUserDetailView_displayUserDetailUnavailableView() {
        let repository = UserDetailRepositoryMock(userDetail: UserDetailDTO.stub().toDomain())
        let userCase = DefaultUserDetailUseCase(userDetailRepository: repository)
        let viewModel = DefaultUserDetailViewModel(userID: 1, userDetailUseCase: userCase)
        let userDetailView = UserDetailView(viewModel: viewModel).contentUnavailableView
        assertSnapshot(of: userDetailView.toVC, as: .image, named: "UserDetail", testName: "userDetailView_unavailable_test")
    }
    
    func testUserDetailView_displayUserDetailView() {
        let repository = UserDetailRepositoryMock(userDetail: UserDetailDTO.stub().toDomain())
        let userCase = DefaultUserDetailUseCase(userDetailRepository: repository)
        let viewModel = DefaultUserDetailViewModel(userID: 1, userDetailUseCase: userCase)
        let userDetailView = UserDetailView(viewModel: viewModel).userDetailView(user: UserDetailDTO.stub().toDomain())
        assertSnapshot(of: userDetailView.toVC, as: .image, named: "UserDetail", testName: "userDetailView_test")
    }
}
