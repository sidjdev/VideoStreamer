//
//  VideoCell.swift
//  VideoStreamer
//
//  Created by Sidharth J Dev on 12/12/24.
//

import UIKit

class VideoCell: UICollectionViewCell {

    @IBOutlet var roundedCorners: [UIView]!
    @IBOutlet weak var likes: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var userProfilePic: UIImageView!
    
    @IBOutlet weak var viewersView: UIStackView!
    @IBOutlet weak var followBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        roundedCorners.append(followBtn)
        roundedCorners.append(viewersView)
        roundedCorners.forEach { element in
            element.layer.cornerRadius = 10
        }
        // Initialization code
    }

    @IBAction func followAct(_ sender: Any) {
    }
}
