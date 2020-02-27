//
//  MockStackOverflowClient.swift
//  stoverflow
//
//  Created by Robert Hamilton on 26/02/2020.
//  Copyright © 2020 Robert Hamilton. All rights reserved.
//

import Foundation

class MockStackOverflowClient: StackOverflowClient {
    
    /// The list of users which will be returned from a UsersRequest
    var usersToReturn: [User] = []
    
    /// Whether a users request will return a successful result
    var usersRequestShouldSucceed: Bool = true
    
    override func makeRequest<T>(_ request: T, completion: @escaping (Result<T.entity, Error>) -> Void) where T : APIRequest {
        if request is UsersRequest {
            if usersRequestShouldSucceed, let users = usersToReturn as? T.entity {
                completion(.success(users))
            } else {
                completion(.failure(StackOverflowAPIError.NoItems))
            }
        }
    }
}
