//
//  CommentsCell.swift
//  VideoStreamer
//
//  Created by Sidharth J Dev on 12/12/24.
//

import UIKit

class CommentsCell: UITableViewCell {
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    func configure(with comment: Comment) {
        usernameLabel.textColor = .white
        commentLabel.textColor = .white
        
        // Set the background to transparent
        backgroundColor = .clear
        usernameLabel.text = comment.username
        commentLabel.text = comment.comment
        
        if let picURL = URL(string: comment.picURL) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: picURL), let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.userProfileImageView.image = image
                    }
                }
            }
        }
    }
}
