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
    override func viewDidLoad() {
        super.viewDidLoad()
        if let data = VideoStreamerUtils.loadVideosData() {
            videos  = data.videos
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
//            comments.forEach { print($0.comment) }
        }
        let nib = UINib(nibName: "VideoCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "videoCell")

        collectionView.dataSource = self
        collectionView.delegate = self

        // Do any additional setup after loading the view.
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
        cell.configure(with: videos[indexPath.item])
            
            return cell
    }
            
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }
}
            
