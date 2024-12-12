//
//  VideoCell.swift
//  VideoStreamer
//
//  Created by Sidharth J Dev on 12/12/24.
//

import UIKit
import AVKit

class VideoCell: UICollectionViewCell {

    @IBOutlet var roundedCorners: [UIView]!
    @IBOutlet weak var likes: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var userProfilePic: UIImageView!
    
    @IBOutlet weak var viewersView: UIStackView!
    @IBOutlet weak var followBtn: UIButton!
    
    @IBOutlet weak var videoContainerView: UIView!
    private var player: AVPlayer?
    private var playerLayer: AVPlayerLayer?
    override func awakeFromNib() {
        super.awakeFromNib()
        roundedCorners.append(followBtn)
//        roundedCorners.append(viewersView)
        roundedCorners.forEach { element in
            element.layer.cornerRadius = 10
        }
        // Initialization code
    }

    @IBAction func followAct(_ sender: Any) {
    }
    
    func configure(with video: Video) {
//            titleLabel.text = video.username
            if let thumbnailURL = URL(string: video.thumbnail) {
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: thumbnailURL), let image = UIImage(data: data) {
                        DispatchQueue.main.async {
//                            self.thumbnailImageView.image = image
                        }
                    }
                }
            }

            if let videoURL = URL(string: video.video) {
                setupVideoPlayer(with: videoURL)
            }
        }

        private func setupVideoPlayer(with url: URL) {
            // Remove existing player layer if needed
            playerLayer?.removeFromSuperlayer()

            // Initialize the player
            player = AVPlayer(url: url)

            // Create a player layer and add it to the videoContainerView
            playerLayer = AVPlayerLayer(player: player)
            playerLayer?.frame = videoContainerView.bounds
            playerLayer?.videoGravity = .resizeAspectFill

            if let playerLayer = playerLayer {
                videoContainerView.layer.addSublayer(playerLayer)
            }
        }

        override func prepareForReuse() {
            super.prepareForReuse()

            // Reset player to avoid overlapping videos
            player?.pause()
            player = nil
            playerLayer?.removeFromSuperlayer()
            playerLayer = nil
        }
}
