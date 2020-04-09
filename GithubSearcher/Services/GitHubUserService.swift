//
//  GitHubUserService.swift
//  GithubSearcher
//
//  Created by praveen velanati on 4/8/20.
//  Copyright © 2020 praveen velanati. All rights reserved.
//

import Foundation

class GitHubUserService {
    
    
    var baseURL: URL? = {
        URL(string: "https://api.github.com/users/praveenvelanati")
    }()
    
    let session = URLSession.shared
    func fetchUserInfo(with request: UserSearchRequest, completion: @escaping (Result<GithubUser, Error>) -> Void) {
        
        let urlRequest = URLRequest(url: baseURL!)
        session.dataTask(with: urlRequest) { (data, response, error) in
            guard let httpResponse = response as?HTTPURLResponse, httpResponse.statusCode == 200, let responseData = data else {
                completion(.failure(ApiError.NetworkUnavailable))
                return
            }
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            jsonDecoder.dateDecodingStrategy = .formatted(DateFormatter.dateFormatter)
            
            do {
                let githubUser = try jsonDecoder.decode(GithubUser.self, from: responseData)
                completion(.success(githubUser))
            } catch {
                completion(.failure(error))
            }
        }.resume()
        
    }
    
    
    func fetchUserPublicRepos(with request: UserSearchRequest, completion: @escaping (Result<[Repo], Error>) -> Void) {
        let url = URL(string: "https://api.github.com/users/praveenvelanati/repos")
        let urlRequest = URLRequest(url: url!)
        session.dataTask(with: urlRequest) { (data, response, error) in
            guard let httpResponse = response as?HTTPURLResponse, httpResponse.statusCode == 200, let responseData = data else {
                completion(.failure(ApiError.NetworkUnavailable))
                return
            }
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let repos = try jsonDecoder.decode([Repo].self, from: responseData)
                completion(.success(repos))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
}
