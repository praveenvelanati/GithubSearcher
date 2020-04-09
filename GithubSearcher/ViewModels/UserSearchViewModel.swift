//
//  UserSearchViewModel.swift
//  GithubSearcher
//
//  Created by praveen velanati on 4/8/20.
//  Copyright © 2020 praveen velanati. All rights reserved.
//

import Foundation

class UserSearchViewModel {
    
    let githubService = GitHubService()
    
    var userSearchResults: UserSearchResults?
    
    var updateUserList: (([GithubUser]) -> Void)?
    
    func searchForUsers(with username: String) {
        guard username.count > 0 else {
            return
        }
        let userSearchRequest = GithubRequest(path: "search/users", queryParams: ["q": username])
        githubService.fetchSearchResults(with: userSearchRequest) { [weak self] (result) in
            switch result {
            case .success(let results):
                self?.userSearchResults = results
                self?.updateUserList?(results.items)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
