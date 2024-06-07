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
    
    var path: URL!
    
    override func setUp() {
        super.setUp()
        path = getImageFromBundle(resource: "sample", withExtension: "jpg")
    }
    
    override func tearDown() {
        path = nil
        super.tearDown()
    }
    
    func testUserDetailView_displayUserDetailUnavailableView() {
        let userDetailView = UserContentUnavailableView(type: .userDetail)
        
        userDetailView.toVC.performSnapshotTest(named: "UserDetail_Unavailable",
                                                testName: "UserDetail")
    }
}
