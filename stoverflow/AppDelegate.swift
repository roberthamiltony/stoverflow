//
//  AppDelegate.swift
//  stoverflow
//
//  Created by Robert Hamilton on 22/02/2020.
//  Copyright © 2020 Robert Hamilton. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    private var isUsingMocks: Bool = false
    private static let mockUsersPath = "mockUsers"
    private static let resetDatabase = "resetDatabase"
    static let usingMocksArugment = "usingMockData"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let arguments = ProcessInfo.processInfo.arguments
        if arguments.contains(AppDelegate.resetDatabase) {
            clearDatabase()
        }
        isUsingMocks = arguments.contains(AppDelegate.usingMocksArugment)
        if isUsingMocks {
            configureMockStackOverflowClient()
        }
        return true
    }
    
    private func configureMockStackOverflowClient() {
        if
            let mockClient = StackOverflowClient.shared as? MockStackOverflowClient,
            let mockUsersFile = Bundle.main.path(forResource: AppDelegate.mockUsersPath, ofType: "json") {
                let mockUsersURL = URL(fileURLWithPath: mockUsersFile)
                if let data = try? Data(contentsOf: mockUsersURL, options: .mappedIfSafe),
                    let users = try? JSONDecoder().decode([User].self, from: data) {
                    mockClient.usersToReturn = users
                }
        }
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = isUsingMocks ?
            NSPersistentContainer(name: "stoverflow", managedObjectModel: self.mockManagedObjectModel) :
            NSPersistentContainer(name: "stoverflow")
        container.loadPersistentStores() { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    private lazy var mockManagedObjectModel: NSManagedObjectModel = {
        guard let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle(for: type(of: self))] ) else {
            fatalError("Failed to create mock object model")
        }
        return managedObjectModel
    }()
    
    private func clearDatabase() {
        guard let url = persistentContainer.persistentStoreDescriptions.first?.url else { return }
        let persistentStoreCoordinator = persistentContainer.persistentStoreCoordinator
         do {
             try persistentStoreCoordinator.destroyPersistentStore(at: url, ofType: NSSQLiteStoreType, options: nil)
             try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
         } catch let error {
             print("Attempted to clear persistent store: " + error.localizedDescription)
        }
    }

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
