//
//  DefaultAPIClient.swift
//  MusicalBoom
//
//  Created by mac on 24.02.2018.
//  Copyright © 2018 Kamil Chołyk. All rights reserved.
//

import Foundation

final class DefaultAPIClient: APIClient {
    
    private let session: URLSession
    private let token = "ruDboTcLUPhRJTvKzOjfIhdWAJmXCtnJSpEvnjet"
    
    init() {
        session = .shared
    }
    
    func send(request: APIRequest, completion: @escaping (Result<Data>) -> ()) {
        do {
            var request = try URLRequest(request: request)
            let headerValue = "Discogs token=\(token)"
            request.setValue(headerValue, forHTTPHeaderField: "Authorization")
            session.dataTask(with: request, completionHandler: { (data, response, error) in
                if let data = data {
                    completion(Result.success(data))
                } else if let error = error {
                    completion(Result.failure(error))
                }
            }).resume()
        } catch let error {
            completion(Result<Data>.failure(error))
        }
    }
}
