//
//  DashboardTableViewCellViewModelTests.swift
//  stoverflowTests
//
//  Created by Robert Hamilton on 26/02/2020.
//  Copyright © 2020 Robert Hamilton. All rights reserved.
//

import XCTest
import CoreData
@testable import stoverflow

class DashboardTableViewCellViewModelTests: XCTestCase {
    // TODO add tests for image fetching
    private let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    private var followingDelegateCalled: Bool!
    private var blockedDelegateCalled: Bool!
    override func setUp() {
        followingDelegateCalled = false
        blockedDelegateCalled = false
    }
    
    func testNewViewModelCreatesNewCustomUser() {
        let user = UserFactory.shared.makeUser()
        let _ = DashboardTableViewCellViewModel(user: user)
        XCTAssertEqual(getPersistentUsers(withID: user.userId).count, 1)
    }
    
    func testDuplicateViewModelDoesNotCreateDuplicateCustomUser() {
        let user = UserFactory.shared.makeUser()
        let _ = DashboardTableViewCellViewModel(user: user)
        let _ = DashboardTableViewCellViewModel(user: user)
        XCTAssertEqual(getPersistentUsers(withID: user.userId).count, 1)
    }
    
    func testCanFollowUser() {
        let user = UserFactory.shared.makeUser()
        let vm = DashboardTableViewCellViewModel(user: user)
        vm.following = true
        XCTAssertTrue(getPersistentUsers(withID: user.userId).first?.following ?? false)
    }
    
    func testCanUnfollowUser() {
        let user = UserFactory.shared.makeUser()
        let vm = DashboardTableViewCellViewModel(user: user)
        vm.following = true
        XCTAssertTrue(getPersistentUsers(withID: user.userId).first?.following ?? false)
        vm.following = false
        XCTAssertFalse(getPersistentUsers(withID: user.userId).first?.following ?? true)
    }
    
    func testCanBlockUser() {
        let user = UserFactory.shared.makeUser()
        let vm = DashboardTableViewCellViewModel(user: user)
        vm.blocked = true
        XCTAssertTrue(getPersistentUsers(withID: user.userId).first?.blocked ?? false)
    }
    
    func testBlockedUpdateDelegateIsCalledOnSetToTrue() {
        let user = UserFactory.shared.makeUser()
        let vm = DashboardTableViewCellViewModel(user: user)
        vm.delegate = self
        vm.blocked = true
        XCTAssertTrue(blockedDelegateCalled)
    }
    
    func testBlockedUpdateDelegateIsCalledOnSetToFalse() {
        let user = UserFactory.shared.makeUser()
        let vm = DashboardTableViewCellViewModel(user: user)
        vm.delegate = self
        vm.blocked = false
        XCTAssertTrue(blockedDelegateCalled)
    }
    
    func testFollowUpdateDelegateIsCalledOnSetToTrue() {
        let user = UserFactory.shared.makeUser()
        let vm = DashboardTableViewCellViewModel(user: user)
        vm.delegate = self
        vm.following = true
        XCTAssertTrue(followingDelegateCalled)
    }
    
    func testFollowUpdateDelegateIsCalledOnSetToFalse() {
        let user = UserFactory.shared.makeUser()
        let vm = DashboardTableViewCellViewModel(user: user)
        vm.delegate = self
        vm.following = false
        XCTAssertTrue(followingDelegateCalled)
    }
    
    func getPersistentUsers(withID id: Int) -> [CustomStackOverflowUser] {
        let request: NSFetchRequest<CustomStackOverflowUser> = CustomStackOverflowUser.fetchRequest()
        request.predicate = NSPredicate(format: "userID = \(String(id))")
        do {
            if let context = context {
                let users = try context.fetch(request)
                return users
            }
        } catch {
            print("Error loading data \(error)")
        }
        return []
    }
}

extension DashboardTableViewCellViewModelTests: DashboardTableViewCellViewModelDelegate {
    func viewModelDidUpdateFollowingState(_ viewModel: DashboardTableViewCellViewModel) {
        followingDelegateCalled = true
    }
    
    func viewModelDidUpdateBlockedState(_ viewModel: DashboardTableViewCellViewModel) {
        blockedDelegateCalled = true
    }
    
    
}
