//
//  JsonDecodingStrategy.swift
//  GithubSearcher
//
//  Created by praveen velanati on 4/9/20.
//  Copyright © 2020 praveen velanati. All rights reserved.
//

import Foundation

struct JsonDecodingStrategy {
    
    
    func decode<T: Codable>(type: T.Type, response: URLResponse?, data: Data?, error: Error?) -> Result<T, Error> {
        guard let httpResponse = response as?HTTPURLResponse, let responseData = data else {
            return Result.failure(ApiError.NetworkUnavailable)
        }
        switch httpResponse.statusCode {
        case 200...299:
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            jsonDecoder.dateDecodingStrategy = .formatted(DateFormatter.dateFormatter)
            
            do {
                let result = try jsonDecoder.decode(T.self, from: responseData)
                return Result.success(result)
            } catch {
                return Result.failure(error)
            }
        case 403:
            return Result.failure(ApiError.RequestLimitExceeded)
        default:
            return Result.failure(ApiError.unknownError)
        }
        
        
    }
    
}
