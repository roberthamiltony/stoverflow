//
//  URLExtensions.swift
//  stoverflow
//
//  Created by Robert Hamilton on 23/02/2020.
//  Copyright © 2020 Robert Hamilton. All rights reserved.
//

import Foundation

extension URL {
    
    /// Convinience function to create a URL with parameters
    /// - Parameters:
    ///   - string: A string representation of a URL
    ///   - parameters: A set of key value parameters to attach to the URL
    static func makeURLWithParameters(string: String, parameters: [String: String]?) -> URL? {
        var urlComps = URLComponents(string: string)
        if urlComps != nil, let parameters = parameters, !parameters.isEmpty {
            var items: [URLQueryItem] = []
            for (key, value) in parameters {
                items.append(URLQueryItem(name: key, value: value))
            }
            urlComps?.queryItems = items
        }
        return urlComps?.url
    }
}
