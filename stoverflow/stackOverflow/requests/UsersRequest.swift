//
//  UsersRequest.swift
//  stoverflow
//
//  Created by Robert Hamilton on 23/02/2020.
//  Copyright © 2020 Robert Hamilton. All rights reserved.
//

import Foundation

/// An helper struct for making an API request for a list of users
struct UsersRequest: APIRequest {
    let resourcePath = "users"
    
    let parameters: [String : String]?
    
    typealias entity = [User]
    
    init(pageSize: Int) {
        parameters = [
            "pagesize": String(pageSize),
            "order": "desc",
            "sort": "reputation",
            "site": "stackoverflow"
        ]
    }
}
