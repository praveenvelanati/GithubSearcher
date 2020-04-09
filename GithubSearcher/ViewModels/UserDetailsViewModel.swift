//
//  UserDetailsViewModel.swift
//  GithubSearcher
//
//  Created by praveen velanati on 4/9/20.
//  Copyright © 2020 praveen velanati. All rights reserved.
//

import Foundation

class UserDetailsViewModel {
    
    var userService = GitHubUserService()
    var username: String = ""
    var userInfoCallback: ((GithubUser) -> Void)?
    var reposCallback: (([Repo]) -> Void)?
    var errorCallback: ((String) -> Void)?
    var reposErrorCallback: ((String) -> Void)?
    
    init() {}
    
    init(username: String) {
        self.username = username
    }
    
    func fetchUserDetails() {
        userService.fetchUserInfo(with: GithubRequest(path: "users/\(username)")) { [weak self] (result) in
            switch result {
            case.success(let user):
                self?.userInfoCallback?(user)
            case .failure(let error):
                if let apiError = error as? ApiError {
                    self?.errorCallback?(apiError.message)
                }
            }
        }
    }
    
    func userRepos() {
        userService.fetchUserPublicRepos(with: GithubRequest(path: "users/\(username)/repos")) { [weak self] (results) in
            switch results {
            case.success(let repos):
                self?.reposCallback?(repos)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
