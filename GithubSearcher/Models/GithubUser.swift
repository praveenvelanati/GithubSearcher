//
//  GithubUser.swift
//  GithubSearcher
//
//  Created by praveen velanati on 4/8/20.
//  Copyright © 2020 praveen velanati. All rights reserved.
//

import Foundation

struct GithubUser: Codable {
    
    var login: String?
    var id: Int?
    var avatarUrl: URL?
    var url: URL?
    var reposUrl: URL?
    var type: String?
    var score: Double?
    var name: String?
    var location: String?
    var email: String?
    var bio: String?
    var publicRepos: Int?
    var followers: Int?
    var following: Int?
    var createdAt: Date?
    var updatedAt: Date?
    
}

extension DateFormatter {
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }()
}
