//
//  UserSearchTableViewController.swift
//  GithubSearcher
//
//  Created by praveen velanati on 4/8/20.
//  Copyright © 2020 praveen velanati. All rights reserved.
//

import UIKit
import Kingfisher

final class UserSearchTableViewController: UITableViewController {
    
    // Search Results will be displayed in the same view.
    var searchController = UISearchController(searchResultsController: nil)
    var viewmodel = UserSearchViewModel()
    
    var users = [GithubUser]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "GitHub Searcher"
        self.navigationController?.navigationBar.isTranslucent = false
        configureSearchBar()
        registerCallbacks()
    }
    
    func registerCallbacks() {
        viewmodel.updateUserList = { [weak self] (matchedUsers) in
            self?.users = matchedUsers
        }
        viewmodel.errorCallback = { (errorMessage) in
            print(errorMessage)
        }
    }
    
    func configureSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for Users"
        searchController.searchBar.sizeToFit()
        searchController.searchBar.returnKeyType = .done
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
    }
    
}

extension UserSearchTableViewController {
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return users.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath)
        let user = users[indexPath.row]
        cell.imageView?.layer.borderWidth = 8.0
        cell.imageView?.layer.borderColor = UIColor.white.cgColor
        if let imageurl = user.avatarUrl {
            cell.imageView?.kf.setImage(with: imageurl, placeholder: UIImage(named: "user"), options: [.cacheMemoryOnly])
        }
        cell.textLabel?.text = user.login
        cell.detailTextLabel?.text = "Repo: \(user.score ?? 0)"
        
        return cell
    }
}


// MARK: -Table view delegate

extension UserSearchTableViewController {
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "UserDetailViewController") as? UserDetailViewController else {
            return
        }
        let user = users[indexPath.row]
        guard let username = user.login, username.count > 0 else {
            return
        }
        vc.viewModel = UserDetailsViewModel(username: username)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

extension UserSearchTableViewController: UISearchResultsUpdating {
   
    func updateSearchResults(for searchController: UISearchController) {
        viewmodel.searchForUsers(with: searchController.searchBar.text ?? "")
    }
}
