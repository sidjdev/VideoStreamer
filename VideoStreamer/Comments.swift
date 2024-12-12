//
//  Comments.swift
//  VideoStreamer
//
//  Created by Sidharth J Dev on 12/12/24.
//

import Foundation

struct Comment: Codable {
    let id: Int
    let username: String
    let picURL: String
    let comment: String
}

struct CommentsData: Codable {
    let comments: [Comment]
}
