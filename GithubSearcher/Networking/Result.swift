//
//  Result.swift
//  GithubSearcher
//
//  Created by praveen velanati on 4/8/20.
//  Copyright © 2020 praveen velanati. All rights reserved.
//

import Foundation

enum Result<T, E:Error> {
    case success(T)
    case failure(E)
}


enum ApiError: Error {
    
    case BadRequest
    case NetworkUnavailable
    case RequestLimitExceeded
    case unknownError
    
    var message: String {
        switch self {
        case .BadRequest:
            return "The request url is invalid"
        case .NetworkUnavailable:
            return "The network is unreachable, please check your connection"
        case .RequestLimitExceeded:
            // Not ideal message for production
            return "The request limit exceeded. Please try again in a bit"
        default:
            return "An unknown occured."
        }
    }
    
}
