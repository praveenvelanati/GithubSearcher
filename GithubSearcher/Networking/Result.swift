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
    
    case BadUrl
    case NetworkUnavailable
    
    
}
