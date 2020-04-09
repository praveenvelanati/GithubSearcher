//
//  ReposViewModel.swift
//  GithubSearcher
//
//  Created by praveen velanati on 4/9/20.
//  Copyright © 2020 praveen velanati. All rights reserved.
//

import Foundation

struct ReposViewModel {
    
     var totalRepos = [Repo]()
    
    init(repos: [Repo] = []) {
        self.totalRepos = repos
    }
    
    func filterRepos(with searchText: String) -> [Repo] {
        return totalRepos.filter{ ($0.name?.lowercased().contains(searchText.lowercased()) ?? false)}
    }
    
}
