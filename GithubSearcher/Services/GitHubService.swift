//
//  GitHubService.swift
//  GithubSearcher
//
//  Created by praveen velanati on 4/8/20.
//  Copyright © 2020 praveen velanati. All rights reserved.
//

import Foundation

protocol GitHubServiceType {
    func fetchSearchResults(with request: UserSearchRequest, completion: @escaping (Result<UserSearchResults, Error>) -> Void)
}


class GitHubService: GitHubServiceType {
   
    
    var baseURL: URL? = {
        URL(string: "https://api.github.com/")
    }()
    
    let session = URLSession.shared
    
    func fetchSearchResults(with request: UserSearchRequest, completion: @escaping (Result<UserSearchResults, Error>) -> Void) {
        guard let url = baseURL?.appendingPathComponent(request.path) else {
            completion(.failure(ApiError.BadRequest))
            return
        }
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            return
        }
        let queryItem = URLQueryItem(name: request.queryKey, value: request.queryValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
        urlComponents.queryItems = [URLQueryItem]()
        urlComponents.queryItems?.append(queryItem)
        let urlRequest = URLRequest(url: urlComponents.url!)
        session.dataTask(with: urlRequest) { (data, response, error) in
            guard let httpResponse = response as?HTTPURLResponse, httpResponse.statusCode == 200, let responseData = data else {
                completion(.failure(ApiError.NetworkUnavailable))
                return
            }
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let userSearchResults = try jsonDecoder.decode(UserSearchResults.self, from: responseData)
                completion(.success(userSearchResults))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
}


struct UserSearchRequest {
    var path = "search/users"
    
    var queryKey = "q"
    
    var queryValue: String
    
    init(queryValue: String) {
        self.queryValue = queryValue
    }
    
}
