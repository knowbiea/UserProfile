//
//  UserProfileUITests.swift
//  UserProfileUITests
//
//  Created by Arvind on 31/05/24.
//

import XCTest

final class UserProfileUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testUsertListVisible() {
        let app = XCUIApplication()
        app.launch()
        let scrollView = app.scrollViews
        let listGridView = scrollView.otherElements["userList_listGridView"]
        XCTAssertTrue(listGridView.waitForExistence(timeout: 5), "List View, list should be visible.")
    }
    
    func testUserApp() throws {
        let app = XCUIApplication()
        app.launch()
        
        let grid = app.otherElements["userList_listGridView"]
        let predicate = NSPredicate(format: "identifier BEGINSWITH 'UserItem_'")
        let gridItems = grid.descendants(matching: .any).matching(predicate)
        let firstGridItem = gridItems.element(boundBy: 0)
        firstGridItem.tap()
        app.swipeDown()
      }
}
