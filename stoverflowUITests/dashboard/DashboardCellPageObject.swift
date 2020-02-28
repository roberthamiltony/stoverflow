//
//  DashboardCellPageObject.swift
//  stoverflowUITests
//
//  Created by Robert Hamilton on 27/02/2020.
//  Copyright © 2020 Robert Hamilton. All rights reserved.
//

import Foundation
import XCTest

struct DashboardCellPageObject {
    let cell: XCUIElement
    init(cellElement: XCUIElement) {
        cell = cellElement
    }
    var profileImage: XCUIElement {
        return cell.descendants(matching: .image)[DashboardCellIdentifiers.profileImage.rawValue].firstMatch
    }
    var nameLabel: XCUIElement {
        return cell.descendants(matching: .staticText)[DashboardCellIdentifiers.name.rawValue].firstMatch
    }
    var reputationLabel: XCUIElement {
        return cell.descendants(matching: .staticText)[DashboardCellIdentifiers.reputation.rawValue].firstMatch
    }
    var follow: XCUIElement {
        return cell.descendants(matching: .any)[DashboardCellIdentifiers.follow.rawValue].firstMatch
    }
    var block: XCUIElement {
        return cell.descendants(matching: .any)[DashboardCellIdentifiers.block.rawValue].firstMatch
    }
}

enum DashboardCellIdentifiers: String {
    case profileImage = "profileImage"
    case name = "name"
    case reputation = "reputation"
    case follow = "follow"
    case block = "block"
}
