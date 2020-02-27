//
//  UserFactory.swift
//  stoverflowTests
//
//  Created by Robert Hamilton on 27/02/2020.
//  Copyright © 2020 Robert Hamilton. All rights reserved.
//

import Foundation
@testable import stoverflow

/// A class to assist with creating mock users
class UserFactory {
    
    /// A singleton instance
    static let shared = UserFactory()
    
    private var lastID = 0
    
    /// Generates a unique User within the context of users created by this instance
    func makeUser() -> User {
        lastID += 1
        return User(aboutMe: nil, acceptRate: nil, accountId: lastID, age: nil, answerCount: nil, creationDate: Date(), displayName: "Pierre-Emerick Aubameyang", downvoteCount: nil, isEmployee: false, lastAccessDate: Date(), lastModifiedDate: nil, link: "", location: nil, profileImage: "", questionCount: nil, reputation: 10, reputationChangeDay: 1, reputationChangeMonth: 1, reputationChangeQuarter: 1, reputationChangeWeek: 1, reputationChangeYear: 1, timedPenaltyDate: Date(), upvoteCount: nil, userId: lastID, userType: "na", viewCount: nil, websiteURL: nil)
    }
}
