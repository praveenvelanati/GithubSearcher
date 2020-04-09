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
    
    var userInfoCallback: ((GithubUser) -> Void)?
    var reposCallback: (([Repo]) -> Void)?
    
    func fetchUserDetails() {
        userService.fetchUserInfo(with: UserSearchRequest(queryValue: "praveenvelanati")) { [weak self] (result) in
            switch result {
            case.success(let user):
                self?.userInfoCallback?(user)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func userRepos() {
        userService.fetchUserPublicRepos(with: UserSearchRequest(queryValue: "")) { [weak self] (results) in
            switch results {
            case.success(let repos):
                self?.reposCallback?(repos)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
