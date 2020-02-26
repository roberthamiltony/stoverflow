//
//  DashboardViewModel.swift
//  stoverflow
//
//  Created by Robert Hamilton on 22/02/2020.
//  Copyright © 2020 Robert Hamilton. All rights reserved.
//

import Foundation
import UIKit

/// A view model to provide data from the stack overflow API for display
class DashboardViewModel {
    
    /// The number of users the view model will attempt to fetch from the stack overflow API
    private static let pageSize = 20
    
    private let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    private let client: StackOverflowClient
    
    /// A list of stack overflow users. This will not be initiallty populated; a delegate should be registered to listen for
    ///  updates
    private (set) var userVMs: [DashboardTableViewCellViewModel] = []
    
    /// A delegate to handle updates from the DashboardViewModel instance
    weak var delegate: DashboardViewModelDelegate?
    
    /// Initializes a DashboardViewModel with a Stack Overflow client, against which to make API calls
    /// - Parameter client: An instnace of StackOverflowClient
    init(client: StackOverflowClient = StackOverflowClient.shared) {
        self.client = client
    }
    
    /// Makes an API call to retrieve a list of users from the Stack Overflow API. The delegate will be informed of the
    ///  result.
    func getUsers() {
        client.makeRequest(UsersRequest(pageSize: DashboardViewModel.pageSize)) { result in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self.delegate?.viewModelGetUsersDidFail(self, error: error)
                }
            case .success(let users):
                let group = DispatchGroup()
                for user in users {
                    let vm = DashboardTableViewCellViewModel(user: user, context: self.context)
                    self.userVMs.append(vm)
                    group.enter()
                    vm.fetchProfileImageData {
                        group.leave()
                    }
                }
                // TODO handle image loading failures
                group.notify(queue: .main) {
                    self.delegate?.viewModelGetUsersDidSucceed(self)
                }
            }
        }
    }
}

/// A delegate interface to be implemented to handle updates from instances of DashboardViewModel
protocol DashboardViewModelDelegate: class {
    
    /// Called to inform the delegate of a failed attempt to retrieve a list of Stack Overflow users
    /// - Parameters:
    ///   - viewModel: The view model which attempted the failed API call
    ///   - error: The error reported for the failure
    func viewModelGetUsersDidFail(_ viewModel: DashboardViewModel, error: Error)
    
    /// Called to inform the delegate of a successful attempt to retrieve a list of Stack Overflow users
    /// - Parameter viewModel: The view model which successfully retrieveds a list of Users
    func viewModelGetUsersDidSucceed(_ viewModel: DashboardViewModel)
}
