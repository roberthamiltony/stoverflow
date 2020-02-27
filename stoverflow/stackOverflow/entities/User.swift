//
//  User.swift
//  stoverflow
//
//  Created by Robert Hamilton on 23/02/2020.
//  Copyright © 2020 Robert Hamilton. All rights reserved.
//

import Foundation

/// Describes a User object returned by the stack overflow API
struct User: Codable {
    var aboutMe: String?
    var acceptRate: Int?
    var accountId: Int
    var age: Int?
    var answerCount: Int?
    // var badgeCounts: Int
    var creationDate: Date
    var displayName: String
    var downvoteCount: Int?
    var isEmployee: Bool
    var lastAccessDate: Date
    var lastModifiedDate: Date?
    var link: String
    var location: String?
    var profileImage: String
    var questionCount: Int?
    var reputation: Int
    var reputationChangeDay: Int
    var reputationChangeMonth: Int
    var reputationChangeQuarter: Int
    var reputationChangeWeek: Int
    var reputationChangeYear: Int
    var timedPenaltyDate: Date?
    var upvoteCount: Int?
    var userId: Int
    var userType: String
    var viewCount: Int?
    var websiteURL: String?
    
    enum CodingKeys: String, CodingKey {
        case aboutMe = "about_me"
        case acceptRate = "accept_rate"
        case accountId = "account_id"
        case age
        case answerCount = "answer_count"
        // case badgesCount = "badges_count"
        case creationDate = "creation_date"
        case displayName = "display_name"
        case downvoteCount = "down_vote_count"
        case isEmployee = "is_employee"
        case lastAccessDate = "last_access_date"
        case lastModifiedDate = "last_modified_date"
        case link
        case location
        case profileImage = "profile_image"
        case questionCount = "question_count"
        case reputation
        case reputationChangeDay = "reputation_change_day"
        case reputationChangeMonth = "reputation_change_month"
        case reputationChangeQuarter = "reputation_change_quarter"
        case reputationChangeWeek = "reputation_change_week"
        case reputationChangeYear = "reputation_change_year"
        case timedPenaltyDate = "timed_penalty_date"
        case upvoteCount = "upvote_count"
        case userId = "user_id"
        case userType = "user_type"
        case viewCount = "view_count"
        case websiteURL = "website_url"
    }
}
