//
//  UserSearchResults.swift
//  GithubSearcher
//
//  Created by praveen velanati on 4/8/20.
//  Copyright © 2020 praveen velanati. All rights reserved.
//

import Foundation

struct UserSearchResults: Codable {
    
    var totalCount: Int
    var incompleteResults: Bool
    var items: [GithubUser]
    
    
}
