//
//  StackOverflowClient.swift
//  stoverflow
//
//  Created by Robert Hamilton on 23/02/2020.
//  Copyright © 2020 Robert Hamilton. All rights reserved.
//

import Foundation

class StackOverflowClient: APIClient {
    /// A shared instance
    static let shared = StackOverflowClient()
    let endpoint = "https://api.stackexchange.com/2.2/"
    private var dataTask: URLSessionDataTask?
    
    func makeRequest<T>(_ request: T, completion: @escaping (Result<T.entity, Error>) -> Void) where T : APIRequest {
        if let url = URL.makeURLWithParameters(string: endpoint + request.resourcePath, parameters: request.parameters) {
            dataTask?.cancel()
            dataTask = URLSession.shared.dataTask(with: url) {data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                if let data = data, let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) {
                    do {
                        let result = try JSONDecoder().decode(Wrapper<T.entity>.self, from: data)
                        if let items = result.items {
                            completion(.success(items))
                        } else {
                            completion(.failure(StackOverflowAPIError.NoItems))
                        }
                    } catch {
                        completion(.failure(error))
                    }
                } else {
                    completion(.failure(APIError.ResponseError(response: response)))
                }
            }
            dataTask?.resume()
        }
    }
}

enum StackOverflowAPIError: Error {
    case NoItems
}
