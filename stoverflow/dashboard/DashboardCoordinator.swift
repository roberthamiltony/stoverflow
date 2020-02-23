//
//  DashboardCoordinator.swift
//  stoverflow
//
//  Created by Robert Hamilton on 22/02/2020.
//  Copyright © 2020 Robert Hamilton. All rights reserved.
//

import Foundation


/// A coordinator for managing the dashboard flow
class DashboardCoordinator: Coordinator {
    private var dashboardViewController: DashboardViewController?
    override func start() {
        let dashboard = DashboardViewController()
        dashboardViewController = dashboard
        dashboard.viewModel = DashboardViewModel()
        navigationController.pushViewController(dashboard, animated: false)
    }
}
