//
//  stoverflowUITests.swift
//  stoverflowUITests
//
//  Created by Robert Hamilton on 22/02/2020.
//  Copyright © 2020 Robert Hamilton. All rights reserved.
//

import XCTest

class stoverflowUITests: XCTestCase {
    var app: XCUIApplication!
    override func setUp() {
        continueAfterFailure = false
        let app = XCUIApplication()
        app.launchArguments = ["usingMockData", "resetDatabase"]
        app.launch()
    }
    
    /// The cell should expand on tap to show the buttons
    func testExpandingCell() {
        let dashboardPage = DashboardPage()
        XCTAssertTrue(dashboardPage.usersTable.waitForExistence(timeout: 1.0))
        guard let userCell = dashboardPage.cell(forRow: 0) else {
            XCTFail("Failed to find user cell")
            return
        }
        XCTAssertTrue(userCell.cell.waitForExistence(timeout: 1.0))
        let oldFrame = userCell.cell.frame
        userCell.cell.tap()
        XCTAssertLessThan(oldFrame.height, userCell.cell.frame.height)
    }
    
    // TODO 4: investiagte why buttons won't appear in accessibility heirarchy
//    /// Tapping the follow button should change the text of the follow button
//    func testFollowingUser() {
//        let dashboardPage = DashboardPage()
//        XCTAssertTrue(dashboardPage.usersTable.waitForExistence(timeout: 1.0))
//        guard let userCell = dashboardPage.cell(forRow: 0) else {
//            XCTFail("Failed to find user cell")
//            return
//        }
//        XCTAssertTrue(userCell.cell.exists)
//        userCell.cell.tap()
//        XCTAssertTrue(userCell.follow.waitForExistence(timeout: 0.5))
//        let oldText = userCell.follow.title
//        userCell.follow.tap()
//        XCTAssertNotEqual(oldText, userCell.follow.title)
//    }
//
//    /// Tapping the block button should change the text of the block button and disable interaction for the cell content
//    func testBlockingUser() {
//        let dashboardPage = DashboardPage()
//        XCTAssertTrue(dashboardPage.usersTable.waitForExistence(timeout: 1.0))
//        guard let userCell = dashboardPage.cell(forRow: 0) else {
//            XCTFail("Failed to find user cell")
//            return
//        }
//        XCTAssertTrue(userCell.cell.exists)
//        userCell.cell.tap()
//        XCTAssertTrue(userCell.block.waitForExistence(timeout: 0.2))
//        let oldText = userCell.block.title
//        userCell.follow.tap()
//        XCTAssertNotEqual(oldText, userCell.block.title)
//        XCTAssertFalse(userCell.follow.isEnabled)
//    }
//
//    /// Tapping the follow button for a followed user should change the text back ot what it was originally
//    func testUnfollowingUser() {
//        let dashboardPage = DashboardPage()
//        XCTAssertTrue(dashboardPage.usersTable.waitForExistence(timeout: 1.0))
//        guard let userCell = dashboardPage.cell(forRow: 0) else {
//            XCTFail("Failed to find user cell")
//            return
//        }
//        XCTAssertTrue(userCell.cell.exists)
//        userCell.cell.tap()
//        XCTAssertTrue(userCell.follow.waitForExistence(timeout: 0.2))
//        let oldText = userCell.follow.title
//        userCell.follow.tap()
//        userCell.follow.tap()
//        XCTAssertEqual(oldText, userCell.follow.title)
//
//    }
}
