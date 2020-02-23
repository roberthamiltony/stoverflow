//
//  AppCoordinator.swift
//  stoverflow
//
//  Created by Robert Hamilton on 22/02/2020.
//  Copyright © 2020 Robert Hamilton. All rights reserved.
//

import Foundation
import UIKit


/// A coordinator for managing transitions between app flows
class AppCoordinator: Coordinator {
    private var dashboardCoordinator: DashboardCoordinator?
    override func start() {
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.view.backgroundColor = .systemBackground
        navigationController.interactivePopGestureRecognizer?.isEnabled = false
        showDashboard()
    }
    
    private func showDashboard() {
        let coordinator = DashboardCoordinator(navigationController: navigationController)
        dashboardCoordinator = coordinator
        coordinator.start()
    }
}
