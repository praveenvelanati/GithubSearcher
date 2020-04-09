//
//  UserDetailViewController.swift
//  GithubSearcher
//
//  Created by praveen velanati on 4/8/20.
//  Copyright © 2020 praveen velanati. All rights reserved.
//

import UIKit

final class UserDetailViewController: UIViewController {
    
    @IBOutlet weak var userInfoContainer: UserInfoView!
    @IBOutlet weak var labelBio: UILabel!
    @IBOutlet weak var repoContainer: UIView!
    
    
    @IBOutlet weak var tableViewRepos: UITableView!
    var viewModel = UserDetailsViewModel()
    var searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchUserDetails()
        viewModel.userRepos()
        registerCallbacks()
    }
    
    func registerCallbacks() {
        viewModel.userInfoCallback = { [weak self] (user) in
            DispatchQueue.main.async {
                self?.configureUserInfo(with: user)
                self?.labelBio.text = user.bio
            }
        }
        
        viewModel.errorCallback = { (message) in
            DispatchQueue.main.async { [weak self] in
                self?.presentAlert(title: "Error", message: message)
            }
        }
        
        viewModel.reposCallback = { [weak self] (repos) in
            DispatchQueue.main.async {
                self?.configureTable(with: repos)
            }
        }
    }
    
    func configureTable(with repos: [Repo]) {
        guard let repoVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ReposTableViewController") as? ReposTableViewController else {
            return
        }
        repoVC.repos = repos
        addChild(repoVC)
        repoVC.view.frame = repoContainer.bounds
        repoContainer.addSubview(repoVC.view)
    }
    
   
    
    func configureUserInfo(with user: GithubUser) {
        let userInfoView = UserInfoView.make()
        userInfoContainer.addSubview(userInfoView)
        userInfoView.constrainEdgesToSuperview()
        let userInfoViewModel = UserInfoViewModel(with: user)
        userInfoView.configure(with: userInfoViewModel)
    }
    
    func configureSearchBar() {
        //searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for Users"
        searchController.searchBar.sizeToFit()
        tableViewRepos.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
    }
    
}
