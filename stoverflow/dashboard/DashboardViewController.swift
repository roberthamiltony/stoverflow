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
    
    private var loadingIndicator: UIActivityIndicatorView!
    
    /// A view model through which the stack overflow data can be accessed
    var viewModel: DashboardViewModel? {
        didSet {
            viewModel?.delegate = self
            viewModel?.getUsers()
            loadViewIfNeeded()
            showLoadingIndicator()
        }
    }
    
    override func viewDidLoad() {
        title = "StackOverflow top 20"
        setupTable()
        setupLoadingIndicator()
    }
    
    private func setupTable() {
        tableView.register(DashboardTableViewCell.self, forCellReuseIdentifier: DashboardViewController.dashboardCellReuseID)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.accessibilityIdentifier = "usersTable"
    }
    
    private func setupLoadingIndicator() {
        let indicator = UIActivityIndicatorView(style: .large)
        loadingIndicator = indicator
        indicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(indicator)
        indicator.centreInSuperview()
        indicator.isHidden = true
        indicator.accessibilityIdentifier = "loadingIndicator"
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
            cell.viewModel = cellVM
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
    
    private func showLoadingIndicator() {
        UIView.animate(withDuration: 0.2) {
            self.loadingIndicator.alpha = 1
            self.loadingIndicator.isHidden = false
            self.loadingIndicator.startAnimating()
        }
    }
    
    private func hideLoadingIndicator() {
        UIView.animate(withDuration: 0.2, animations: {
            self.loadingIndicator.alpha = 0
        }, completion: { _ in
            self.loadingIndicator.isHidden = true
            self.loadingIndicator.stopAnimating()
        })
    }
}

extension DashboardViewController: DashboardViewModelDelegate {
    func viewModelGetUsersDidFail(_ viewModel: DashboardViewModel, error: Error) {
        hideLoadingIndicator()
        let alert = UIAlertController(title: "Failed to load users", message: "Failed to load Stack Overflow users", preferredStyle: .alert)
        let action = UIAlertAction(title: "Retry", style: .default) { (action) in
            self.viewModel?.getUsers()
            self.showLoadingIndicator()
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func viewModelGetUsersDidSucceed(_ viewModel: DashboardViewModel) {
        tableView.reloadData()
        hideLoadingIndicator()
    }
    
    
}
