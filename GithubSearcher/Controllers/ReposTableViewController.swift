//
//  ReposTableViewController.swift
//  GithubSearcher
//
//  Created by praveen velanati on 4/9/20.
//  Copyright © 2020 praveen velanati. All rights reserved.
//

import UIKit
import SafariServices

final class ReposTableViewController: UITableViewController {

    var repos = [Repo]()
    var filteredRepos = [Repo]()
    var searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 40))
    
    var isSearchActive: Bool {
        let text = searchBar.text ?? ""
        return text.count > 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       configureSearchBar()
        tableView.register(UINib(nibName: "RepoTableViewCell", bundle: nil), forCellReuseIdentifier: "RepoTableViewCell")
    }
    
    func configureSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "Search for User's repositories"
        searchBar.showsCancelButton = true
        tableView.tableHeaderView = searchBar
    }

    //MARK: - Navigation
    
    func navigateToSafari(url: URL?) {
        if let url = url {
            let safariVC = SFSafariViewController(url: url)
            safariVC.preferredBarTintColor = .black
            safariVC.preferredControlTintColor = .white
            present(safariVC, animated: true, completion: nil)
        }
    }

}


extension ReposTableViewController {
     
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearchActive {
            return filteredRepos.count
        } else {
            return repos.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RepoTableViewCell", for: indexPath) as? RepoTableViewCell else {
            fatalError("Unable to find cell")
        }
        if isSearchActive {
            cell.configureCell(with: filteredRepos[indexPath.row])
        } else {
            cell.configureCell(with: repos[indexPath.row])
        }
        return cell
    }
    
}


extension ReposTableViewController {
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repo: Repo?
        if isSearchActive {
            repo = filteredRepos[indexPath.row]
        } else {
            repo = repos[indexPath.row]
        }
        navigateToSafari(url: repo?.htmlUrl)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}


extension ReposTableViewController: UISearchBarDelegate {
    
    // MARK: - Search Bar Delegate Methods
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredRepos = repos.filter{ ($0.name?.lowercased().contains(searchText.lowercased()) ?? false)}
        self.tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = false
    }

}
