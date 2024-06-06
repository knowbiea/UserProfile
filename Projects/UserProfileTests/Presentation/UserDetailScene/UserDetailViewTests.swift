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
        
        userDetailView.toVC.performSnapshotTest(named: "UserDetail_Unavailable",
                                                testName: "UserDetail")
    }
    
    func testUserDetailView_displayUserDetailView() {
        let path = getImageFromBundle(resource: "sample", withExtension: "jpg")
        let repository = UserDetailRepositoryMock(userDetail: UserDetailDTO.stub(image: path.absoluteString).toDomain())
        let userCase = DefaultUserDetailUseCase(userDetailRepository: repository)
        let viewModel = DefaultUserDetailViewModel(userID: 1, userDetailUseCase: userCase)
        let userDetailView = UserDetailView(viewModel: viewModel).userDetailView(user: UserDetailDTO.stub(image: path.absoluteString).toDomain())
        
        userDetailView.toVC.performSnapshotTest(named: "UserDetail_View",
                                                testName: "UserDetail")
    }
}
