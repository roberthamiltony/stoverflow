//
//  APIClient.swift
//  stoverflow
//
//  Created by Robert Hamilton on 23/02/2020.
//  Copyright © 2020 Robert Hamilton. All rights reserved.
//

import Foundation


/// A protocol to be implemented by API Clients
protocol APIClient {
    
    /// The endpoint to which API requests should be made
    var endpoint: String { get }
    
    /// Makes a request to the implementation's endpoint
    /// - Parameters:
    ///   - request: An implementation of API Request, to define the path and data type
    ///   - completion: A completion handler, called with the result: an object of the request's entity type, or an error detailing
    ///   what went wrong
    func makeRequest<T: APIRequest>(_ request: T, completion: @escaping RequestResponse<T.entity>)
}

/// Errors which can be generated from API calls
enum APIError: Error {
    case ResponseError(response: URLResponse?)
}
