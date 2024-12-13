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
    
    @IBOutlet weak var commentsTable: UITableView!
    
    private var comments: [Comment] = []
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialize rounded corners
        roundedCorners.append(followBtn)
        roundedCorners.forEach { element in
            element.layer.cornerRadius = 10
        }
        
        commentsTable.backgroundColor = .clear
        commentsTable.separatorStyle = .none
        commentsTable.showsVerticalScrollIndicator = false
        
        // Set up the comments table view
        commentsTable.delegate = self
        commentsTable.dataSource = self
        
        // Register the custom cell
        let nib = UINib(nibName: "CommentsCell", bundle: nil)
        commentsTable.register(nib, forCellReuseIdentifier: "commentsCell")
    }
    
    @IBAction func followAct(_ sender: Any) {
        // Follow button action
    }
    
    func configure(with video: Video, andComments comments: [Comment]) {
        self.comments = comments
        
        // Configure video-related UI
        if let thumbnailURL = URL(string: video.profilePicURL) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: thumbnailURL), let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.userProfilePic.image = image
                    }
                }
            }
        }
        
        username.text = video.username
        likes.text = "\(video.likes)"
        
        // Set up video player
        if let videoURL = URL(string: video.video) {
            DispatchQueue.main.async { [weak self] in
                self?.setupVideoPlayer(with: videoURL)
            }
        }
        
        // Reload the comments table view
        DispatchQueue.main.async {
            self.commentsTable.reloadData()
            self.autoScrollComments()
        }
    }
    
    private func setupVideoPlayer(with url: URL) {
        playerLayer?.removeFromSuperlayer()
        
        // Initialize the player
        player = AVPlayer(url: url)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.frame = videoContainerView.bounds
        playerLayer?.videoGravity = .resizeAspectFill
        
        if let playerLayer = playerLayer {
            videoContainerView.layer.addSublayer(playerLayer)
        }
        
        // Add notification for looping
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(playerDidReachEnd),
            name: .AVPlayerItemDidPlayToEndTime,
            object: player?.currentItem
        )
        
        player?.play()
    }

    @objc private func playerDidReachEnd() {
        player?.seek(to: .zero)
        player?.play()
    }

    func startVideo() {
        player?.play()
    }

    func stopVideo() {
        player?.pause()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        stopVideo()
        NotificationCenter.default.removeObserver(self)
        player = nil
        playerLayer?.removeFromSuperlayer()
    }

    
    private func autoScrollComments() {
        guard comments.count > 0 else { return }
        let indexPath = IndexPath(row: comments.count - 1, section: 0)
        commentsTable.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
    
}

extension VideoCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "commentsCell", for: indexPath) as? CommentsCell else {
            fatalError("Unable to dequeue CommentsCell")
        }
        
        let comment = comments[indexPath.row]
        cell.configure(with: comment) // Assuming your CommentsCell has a `configure(with:)` method
        return cell
    }
}
