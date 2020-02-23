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
    var viewModel: DashboardViewModel? {
        didSet {
            viewModel?.delegate = self
        }
    }
    
    override func viewDidLoad() {
        title = "StackOverflow top 20"
        tableView.register(DashboardTableViewCell.self, forCellReuseIdentifier: DashboardViewController.dashboardCellReuseID)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return viewModel?.userVMs.count ?? 0
        default:
            return 0
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: DashboardViewController.dashboardCellReuseID) as? DashboardTableViewCell, indexPath.row < viewModel?.userVMs.count ?? 0, let cellVM = viewModel?.userVMs[indexPath.row] {
            cell.nameLabel.text = cellVM.user.displayName
            cell.reputationLabel.text = String(cellVM.user.reputation)
            if let data = cellVM.profileImageData {
                cell.profileImage.image = UIImage(data: data)
            }
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

extension DashboardViewController: DashboardViewModelDelegate {
    func viewModelGetUsersDidFail(_ viewModel: DashboardViewModel, error: Error) {
        
    }
    
    func viewModelGetUsersDidSucceed(_ viewModel: DashboardViewModel) {
        tableView.reloadData()
    }
    
    
}
