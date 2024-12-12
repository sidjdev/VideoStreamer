//
//  ViewController.swift
//  VideoStreamer
//
//  Created by Sidharth J Dev on 12/12/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if let data = VideoStreamerUtils.loadCommentsData() {
            let comments = data.comments
            comments.forEach { print($0.comment) }
        }
        // Do any additional setup after loading the view.
    }


}

