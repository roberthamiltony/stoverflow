//
//  DashboardPageObject.swift
//  stoverflowUITests
//
//  Created by Robert Hamilton on 27/02/2020.
//  Copyright © 2020 Robert Hamilton. All rights reserved.
//

import Foundation
import XCTest

struct DashboardPage {
    var numberOfUserCells: Int {
        return usersTable.cells.count
    }
    
    var usersTable: XCUIElement {
        return XCUIApplication().tables[DashboardPageIdentifiers.usersTable.rawValue].firstMatch
    }
    
    func cell(forRow row: Int) -> DashboardCellPageObject? {
        if row < self.numberOfUserCells && row >= 0 {
            let cell = usersTable.cells.allElementsBoundByIndex[row]
            return DashboardCellPageObject(cellElement: cell)
        }
        return nil
    }
    
    var loadingIndicator: XCUIElement {
        return XCUIApplication().activityIndicators[DashboardPageIdentifiers.loadingIndicator.rawValue].firstMatch
    }
}

enum DashboardPageIdentifiers: String {
    case usersTable = "usersTable"
    case loadingIndicator = "loadingIndicator"
}
