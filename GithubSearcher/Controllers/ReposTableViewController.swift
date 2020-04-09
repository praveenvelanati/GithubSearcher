//
//  ReposTableViewController.swift
//  GithubSearcher
//
//  Created by praveen velanati on 4/9/20.
//  Copyright © 2020 praveen velanati. All rights reserved.
//

import UIKit
import SafariServices

class ReposTableViewController: UITableViewController {

    var repos = [Repo]()
    var filteredRepos = [Repo]()
    var searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 40))
    
    var isSearchActive: Bool {
        let text = searchBar.text ?? ""
        return text.count > 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableHeaderView = searchBar
        searchBar.delegate = self
        searchBar.placeholder = "Search for User's repositories"
        searchBar.returnKeyType = .done
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
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if isSearchActive {
            return filteredRepos.count
        } else {
            return repos.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let repo: Repo?
        if isSearchActive {
            repo = filteredRepos[indexPath.row]
        } else {
            repo = repos[indexPath.row]
        }
        cell.textLabel?.text = repo?.name
        return cell
    }
}


extension ReposTableViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repo: Repo?
        if isSearchActive {
            repo = filteredRepos[indexPath.row]
        } else {
            repo = repos[indexPath.row]
        }
        navigateToSafari(url: repo?.htmlUrl)
    }
}


extension ReposTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredRepos = repos.filter{ ($0.name?.contains(searchText) ?? false)}
        self.tableView.reloadData()
    }
}
