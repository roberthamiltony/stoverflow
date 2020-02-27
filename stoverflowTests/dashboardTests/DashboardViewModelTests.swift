//
//  DashboardViewModelTests.swift
//  stoverflowTests
//
//  Created by Robert Hamilton on 26/02/2020.
//  Copyright © 2020 Robert Hamilton. All rights reserved.
//

import XCTest
@testable import stoverflow

class DashboardViewModelTests: XCTestCase {
    var mockClient: MockStackOverflowClient!
    var didFailDelegateCalled: XCTestExpectation!
    var didSucceedDelegateCalled: XCTestExpectation!
    override func setUp() {
        mockClient = MockStackOverflowClient()
        didFailDelegateCalled = XCTestExpectation(description: "did fail")
        didSucceedDelegateCalled = XCTestExpectation(description: "did succeed")
    }
    
    func testViewModelCanRetrieveUsers() {
        let users = [UserFactory.shared.makeUser(), UserFactory.shared.makeUser()]
        mockClient.usersToReturn = users
        mockClient.usersRequestShouldSucceed = true
        let vm = DashboardViewModel(client: mockClient)
        vm.delegate = self
        vm.getUsers()
        wait(for: [didSucceedDelegateCalled], timeout: 1.0)
        for cellVM in vm.userVMs {
            XCTAssertTrue(users.contains { $0.userId == cellVM.user.userId })
        }
    }
    
    func testViewModelCallsFailureDelegateOnFailure() {
        mockClient.usersRequestShouldSucceed = false
        let vm = DashboardViewModel(client: mockClient)
        vm.delegate = self
        vm.getUsers()
        wait(for: [didFailDelegateCalled], timeout: 1.0)
    }
}

extension DashboardViewModelTests: DashboardViewModelDelegate {
    func viewModelGetUsersDidFail(_ viewModel: DashboardViewModel, error: Error) {
        didFailDelegateCalled?.fulfill()
    }
    
    func viewModelGetUsersDidSucceed(_ viewModel: DashboardViewModel) {
        didSucceedDelegateCalled?.fulfill()
    }
}
