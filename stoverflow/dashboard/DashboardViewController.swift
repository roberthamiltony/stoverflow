//
//  DashboardViewController.swift
//  stoverflow
//
//  Created by Robert Hamilton on 22/02/2020.
//  Copyright © 2020 Robert Hamilton. All rights reserved.
//

import Foundation
import UIKit

/// A view controller to display the top 20 stack overflow users in a table
class DashboardViewController: UITableViewController {
    private static let dashboardCellReuseID = "dashboardCellReuseID"
    
    /// A view model through which the stack overflow data can be accessed
    var viewModel: DashboardViewModel?
    
    override func viewDidLoad() {
        title = "StackOverflow top 20"
        tableView.register(DashboardTableViewCell.self, forCellReuseIdentifier: DashboardViewController.dashboardCellReuseID)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        default:
            return 0
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: DashboardViewController.dashboardCellReuseID) as? DashboardTableViewCell {
            cell.nameLabel.text = "hi"
            cell.reputationLabel.text = "5"
            return cell
        } else {
            // This should never be reached
            return DashboardTableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? DashboardTableViewCell {
            cell.isSelected = false
            // TODO fix odd animation
            tableView.beginUpdates()
            cell.toggleExpandedState()
            tableView.endUpdates()
        }
    }
    
}
