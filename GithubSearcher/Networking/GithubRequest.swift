//
//  GithubRequest.swift
//  GithubSearcher
//
//  Created by praveen velanati on 4/9/20.
//  Copyright © 2020 praveen velanati. All rights reserved.
//

import Foundation

struct GithubRequest {
    var path = "search/users"
    var baseURL: URL? = {
        URL(string: "https://api.github.com/")
    }()
    
    var queryItems = [URLQueryItem]()
    
    init(path: String, queryParams: [String: String] = [:]) {
        self.path = path
        for(key, value) in queryParams {
            let queryItem = URLQueryItem(name: key, value: value)
            self.queryItems.append(queryItem)
        }
    }
    
    func buildRequestURL() -> URL? {
        guard let url = baseURL?.appendingPathComponent(self.path) else {
            return nil
        }
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else  {
            return nil
        }
        urlComponents.queryItems = self.queryItems
        return  urlComponents.url
    }
    
}
