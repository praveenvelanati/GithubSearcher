//
//  GitHubService.swift
//  GithubSearcher
//
//  Created by praveen velanati on 4/8/20.
//  Copyright © 2020 praveen velanati. All rights reserved.
//

import Foundation

protocol GitHubServiceType {
    func fetchSearchResults(with request: GithubRequest, completion: @escaping (Result<UserSearchResults, Error>) -> Void)
}


class GitHubService: GitHubServiceType {
    
    let session = URLSession.shared
    
    func fetchSearchResults(with request: GithubRequest, completion: @escaping (Result<UserSearchResults, Error>) -> Void) {
        guard let url = request.buildRequestURL() else {
            completion(.failure(ApiError.BadRequest))
            return
        }
        let urlRequest = URLRequest(url: url)
        session.dataTask(with: urlRequest) { (data, response, error) in
            let result = JsonDecodingStrategy().decode(type: UserSearchResults.self, response: response, data: data, error: error)
            completion(result)
        }.resume()
    }
    
}
