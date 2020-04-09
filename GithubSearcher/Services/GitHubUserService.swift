//
//  GitHubUserService.swift
//  GithubSearcher
//
//  Created by praveen velanati on 4/8/20.
//  Copyright © 2020 praveen velanati. All rights reserved.
//

import Foundation

class GitHubUserService {
    
    
    let session = URLSession.shared
    
    func fetchUserInfo(with request: GithubRequest, completion: @escaping (Result<GithubUser, Error>) -> Void) {
        
        guard let url = request.buildRequestURL() else {
            completion(.failure(ApiError.BadRequest))
            return
        }
        let urlRequest = URLRequest(url: url)
        session.dataTask(with: urlRequest) { (data, response, error) in
            let result = JsonDecodingStrategy().decode(type: GithubUser.self, response: response, data: data, error: error)
            completion(result)
        }.resume()
        
    }
    
    
    func fetchUserPublicRepos(with request:GithubRequest, completion: @escaping (Result<[Repo], Error>) -> Void) {
        
        guard let url = request.buildRequestURL() else {
            completion(.failure(ApiError.BadRequest))
            return
        }
        let urlRequest = URLRequest(url: url)
        session.dataTask(with: urlRequest) { (data, response, error) in
            let result = JsonDecodingStrategy().decode(type: [Repo].self, response: response, data: data, error: error)
            completion(result)
        }.resume()
        
    }
    
    
}
