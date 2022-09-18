//
//  PostCell.swift
//  TestRX
//
//  Created by Mahmoud Alkady on 13/09/2022.
//

import UIKit

class PostCell: UITableViewCell {

    //MARK:- Outlets.
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var likes: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    
    //MARK:- Propreties.
    var post: Post! {
        didSet {
            setupUI()
            displayData()
        }
    }
}

// MARK: - Private Methods
extension PostCell {
    private func setupUI() {
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        postImage.layer.cornerRadius = 14
    }
    private func displayData() {
        userName.text = post.user
        likes.text = String(post.likes)
        profileImage.kf.setImage(with: post.getUserImageURL(), placeholder: UIImage(named: "profile"))
        postImage.kf.setImage(with: post.getImageURL(), placeholder: UIImage(named: "placeholder"))
    }
}
