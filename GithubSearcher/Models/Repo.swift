//
//  Repo.swift
//  GithubSearcher
//
//  Created by praveen velanati on 4/9/20.
//  Copyright © 2020 praveen velanati. All rights reserved.
//

import Foundation

struct Repo: Codable {
    
    var name: String?
    var stargazersCount: Int?
    var forks: Int?
    var htmlUrl: URL?
    
}
