//
//  DashboardTableViewCellViewModel.swift
//  stoverflow
//
//  Created by Robert Hamilton on 23/02/2020.
//  Copyright © 2020 Robert Hamilton. All rights reserved.
//

import Foundation
import UIKit
import CoreData

/// A view model to wrap a User instance, providing access to the user's information and derived data
class DashboardTableViewCellViewModel {
    private var context: NSManagedObjectContext?
    
    /// The stack overflow user to configure the TableView cell with
    let user: User
    private var decoratedUser: CustomStackOverflowUser?
    
    /// Whether the stack overflow user is being followed
    var following: Bool? {
        get {
            return decoratedUser?.following
        }
        set {
            if let newValue = newValue {
                decoratedUser?.following = newValue
                saveContext()
                delegate?.viewModelDidUpdateFollowingState(self)
            }
        }
    }
    
    /// Whether the stack overflow user is blocked
    var blocked: Bool? {
        get {
            return decoratedUser?.blocked
        }
        set {
            if let newValue = newValue {
                decoratedUser?.blocked = newValue
                saveContext()
                delegate?.viewModelDidUpdateBlockedState(self)
            }
        }
    }
    
    /// A delegate to handle updates from this instance
    var delegate: DashboardTableViewCellViewModelDelegate?
    
    private var task: URLSessionDataTask?
    
    /// The data for the user's profile image data
    private (set) var profileImageData: Data?
    
    /// Initializes an instance of DashboardTableViewCellViewModel, with a StackOverflow user
    /// - Parameter user: A StackOverflow user instance
    init(user: User, context: NSManagedObjectContext? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext) {
        self.user = user
        self.context = context
        loadData()
        if decoratedUser == nil {
            initializeData()
        }
    }
    
    /// Attempts to fetch data for the profile image url for the instance's user
    /// - Parameter completion: A completion handler, called when the data fetching completes
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
    
    private func loadData() {
        let request: NSFetchRequest<CustomStackOverflowUser> = CustomStackOverflowUser.fetchRequest()
        request.predicate = NSPredicate(format: "userID = \(String(user.userId))")
        do {
            if let context = context {
                decoratedUser = try context.fetch(request).first
            }
        } catch {
            print("Error loading data \(error)")
        }
    }
    
    private func initializeData() {
        if let context = context {
            let decorated = CustomStackOverflowUser(context: context)
            decorated.userID = String(user.userId)
            decorated.blocked = false
            decorated.following = false
            decoratedUser = decorated
            saveContext()
        }
    }
    
    private func saveContext() {
        do {
            try context?.save()
        } catch {
            print("Error saving data \(error)")
        }
    }
}

/// A protocol to be implemented to receive update from a DashboardTableViewCellViewModel instance
protocol DashboardTableViewCellViewModelDelegate {
    
    /// Called when the following state of the view model updates
    /// - Parameter viewModel: The view model which has an updated following state
    func viewModelDidUpdateFollowingState(_ viewModel: DashboardTableViewCellViewModel)
    
    /// Called when the blocked state of the view model updates
    /// - Parameter viewModel: The view model whch has an updated blocked state
    func viewModelDidUpdateBlockedState(_ viewModel: DashboardTableViewCellViewModel)
}
