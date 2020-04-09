//
//  GithubUser.swift
//  GithubSearcher
//
//  Created by praveen velanati on 4/8/20.
//  Copyright © 2020 praveen velanati. All rights reserved.
//

import Foundation

struct GithubUser: Codable {
    
    var login: String
    var id: Int
    var nodeId: String
    var avatarUrl: URL?
    var gravatarId: String
    var url: URL?
    var htmlUrl: URL?
    var followersUrl: URL?
    var subscriptionsUrl: URL?
    var organizationsUrl: URL?
    var reposUrl: URL?
    var receivedEventsUrl: URL?
    var type: String
    var score: Double
    
}
