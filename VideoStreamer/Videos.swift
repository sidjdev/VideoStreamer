//
//  Videos.swift
//  VideoStreamer
//
//  Created by Sidharth J Dev on 12/12/24.
//

import Foundation

struct Videos: Codable {
    let id: Int
    let userID: Int
    let username: String
    let profilePicURL: String
    let description: String
    let topic: String
    let viewers: Int
    let likes: Int
    let video: String
    let thumbnail: String
}

struct VideosData: Codable {
    let videos: [Videos]
}

