//
//  RepoTableViewCell.swift
//  GithubSearcher
//
//  Created by praveen velanati on 4/9/20.
//  Copyright © 2020 praveen velanati. All rights reserved.
//

import UIKit

class RepoTableViewCell: UITableViewCell {

    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var labelForkCount: UILabel!
    @IBOutlet weak var labelStarCount: UILabel!
    
   
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(with repo: Repo) {
        repoNameLabel.text = repo.name
        labelForkCount.text = "\(repo.forks ?? 0) Forks"
        labelStarCount.text = "\(repo.stargazersCount ?? 0) Stars"
    }
    
}



