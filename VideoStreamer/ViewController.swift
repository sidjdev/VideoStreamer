//
//  ViewController.swift
//  VideoStreamer
//
//  Created by Sidharth J Dev on 12/12/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var videos: [Video] = []
    var comments: [Comment] = []
    
    private var scrollTimer: Timer?
    
    private var currentlyPlayingCell: VideoCell?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let data = VideoStreamerUtils.loadVideosData() {
            videos  = data.videos
            if let commentsData = VideoStreamerUtils.loadCommentsData() {
                comments = commentsData.comments
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
            
//            comments.forEach { print($0.comment) }
        }
        let nib = UINib(nibName: "VideoCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "videoCell")

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true

        // Do any additional setup after loading the view.
    }
    
//    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//            stopScrollTimer()
//        }
//        
//        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//            playVisibleVideo()
//            startScrollTimer()
//        }
        
    private func playVisibleVideo() {
        // Find the visible cell
        guard let visibleCell = collectionView.visibleCells.first as? VideoCell else { return }
        
        // Stop the currently playing cell if it's not the same as the visible cell
        if let currentlyPlayingCell = currentlyPlayingCell {
            currentlyPlayingCell.stopVideo()
        }
        
        // Start the video on the new visible cell
        visibleCell.startVideo()
        
        // Update the currently playing cell reference
        currentlyPlayingCell = visibleCell
    }

        
        private func startScrollTimer() {
            scrollTimer?.invalidate()
            scrollTimer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { [weak self] _ in
                self?.playVisibleVideo()
            }
        }
        
        private func stopScrollTimer() {
            scrollTimer?.invalidate()
            scrollTimer = nil
        }
    
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "videoCell", for: indexPath) as? VideoCell else {
                fatalError("Unable to dequeue VideoCell with identifier: videoCell")
            }
           
//        cell.backgroundColor = .red
        cell.configure(with: videos[indexPath.item], andComments: comments)
            
            return cell
    }
            
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }
}
            
extension ViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        stopScrollTimer() // Stop timer while user scrolls
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        playVisibleVideo()
        startScrollTimer() // Start auto-loop timer
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if collectionView.visibleCells.isEmpty {
            currentlyPlayingCell?.stopVideo()
            currentlyPlayingCell = nil
        }
    }


}
extension UICollectionView {
    func visibleCellsExcludingCurrent() -> [UICollectionViewCell] {
        let visibleCells = self.visibleCells
        guard visibleCells.count > 1 else { return [] }
        return Array(visibleCells.dropFirst())
    }
}
