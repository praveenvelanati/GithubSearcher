//
//  UserInfoView.swift
//  GithubSearcher
//
//  Created by praveen velanati on 4/9/20.
//  Copyright © 2020 praveen velanati. All rights reserved.
//

import UIKit
import Kingfisher

class UserInfoView: UIView {

    @IBOutlet weak var imageViewUser: UIImageView!
    @IBOutlet weak var labelUsername: UILabel!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var labelLocation: UILabel!
    @IBOutlet weak var labelJoinedDate: UILabel!
    @IBOutlet weak var labelFollowers: UILabel!
    @IBOutlet weak var labelFollowing: UILabel!
    
    func configure(with viewModel: UserInfoViewModel) {
        labelUsername.text = viewModel.username
        labelEmail.text = viewModel.email
        labelLocation.text = viewModel.location
        labelJoinedDate.text = viewModel.joinedDate
        labelFollowers.text = viewModel.followers
        labelFollowing.text = viewModel.following
        if let imageUrl = viewModel.imageUrl {
            imageViewUser.kf.setImage(with: imageUrl, placeholder: UIImage(named: "user"), options: [.cacheMemoryOnly])
        }
    }

}

struct UserInfoViewModel {
    
    let username: String?
    let email: String?
    let location: String?
    let joinedDate: String?
    let followers: String?
    let following: String?
    let imageUrl: URL?
    
    init(with user: GithubUser) {
        self.username = user.login
        self.email = user.email
        self.location = user.location
        self.joinedDate = DateFormatter.readableDateFormat.string(from: user.createdAt ?? Date())
        self.followers = "\(user.followers ?? 0) Followers"
        self.following = "Following \(user.following ?? 0)"
        self.imageUrl = user.avatarUrl
    }
    
}

extension UIView {
    
   static func makeFromNib() -> Self? {
        let nibName = String(describing: self)
        let nib = Bundle.main.loadNibNamed(nibName, owner: self, options: nil)
        return nib?.first { $0 is Self} as? Self
    }
    
    static func make() -> Self {
        let view = makeFromNib() ?? Self.init()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    func constrainEdgesToSuperview() {
        guard let superView = superview else {
            fatalError("There's no superview yo")
        }
        self.topAnchor.constraint(equalTo: superView.topAnchor, constant: 0).isActive = true
        self.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: 0).isActive = true
        self.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: 0).isActive = true
        self.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: 0).isActive = true
    }
    
}
