//
//  Wrapper.swift
//  stoverflow
//
//  Created by Robert Hamilton on 23/02/2020.
//  Copyright © 2020 Robert Hamilton. All rights reserved.
//

import Foundation

struct Wrapper<T : Codable>: Codable {
    var backoff: Int?
    var errorId: Int?
    var errorMessage: String?
    var errorName: String?
    var hasMore: Bool?
    var items: T?
    var page: Int?
    var pageSize: Int?
    var quotaMax: Int?
    var quotaRemaining: Int?
    var total: Int?
    var type: String?
    
    enum CodingKeys: String, CodingKey {
        case backoff
        case errorId = "error_id"
        case errorMessage = "error_message"
        case errorName = "error_name"
        case hasMore = "has_more"
        case items
        case page
        case pageSize = "page_size"
        case quotaMax = "quota_max"
        case quotaRemaining = "quota_remaining"
        case total
        case type
    }
}
