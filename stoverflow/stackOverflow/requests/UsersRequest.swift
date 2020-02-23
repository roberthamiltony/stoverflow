//
//  UsersRequest.swift
//  stoverflow
//
//  Created by Robert Hamilton on 23/02/2020.
//  Copyright © 2020 Robert Hamilton. All rights reserved.
//

import Foundation

struct UsersRequest: APIRequest {
    let resourcePath = "users"
    
    let parameters: [String : String]? = [
        "order": "desc",
        "sort": "reputation",
        "site": "stackoverflow"
    ]
    
    typealias entity = [User]
    
    
}
