//
//  DashboardTableViewCellViewModel.swift
//  stoverflow
//
//  Created by Robert Hamilton on 23/02/2020.
//  Copyright © 2020 Robert Hamilton. All rights reserved.
//

import Foundation

/// A view model to wrap a User instance, providing access to the user's information and derived data
class DashboardTableViewCellViewModel {
    
    /// The stack overflow user to configure the TableView cell with
    let user: User
    
    private var task: URLSessionDataTask?
    
    /// The data for the user's profile image data
    private (set) var profileImageData: Data?
    
    /// Initializes an instance of DashboardTableViewCellViewModel, with a StackOverflow user
    /// - Parameter user: A StackOverflow user instance
    init(user: User) {
        self.user = user
    }
    
    func fetchProfileImageData(completion: @escaping (() -> Void)) {
        guard let url = URL(string: user.profileImage) else {
            completion()
            return
        }
        task?.cancel()
        task = URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data {
                self.profileImageData = data
            }
            completion()
        }
        task?.resume()
    }
}
