//
//  UserSearchTableViewController.swift
//  GithubSearcher
//
//  Created by praveen velanati on 4/8/20.
//  Copyright © 2020 praveen velanati. All rights reserved.
//

import UIKit

class UserSearchTableViewController: UITableViewController {

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
        configureSearchBar()
        viewmodel.updateUserList = { [weak self] (matchedUsers) in
            self?.users = matchedUsers
        }
    }

    func configureSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for Users"
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
    }
    
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
        cell.imageView?.image = UIImage(systemName: "phone")
        cell.textLabel?.text = user.login
        cell.detailTextLabel?.text = "Repo: \(user.score ?? 0)"
        return cell
    }
    
    // MARK: -Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "UserDetailViewController") as? UserDetailViewController else {
            return
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    


}

extension UserSearchTableViewController: UISearchResultsUpdating {
   
    func updateSearchResults(for searchController: UISearchController) {
        viewmodel.searchForUsers(with: searchController.searchBar.text ?? "")
    }

}
