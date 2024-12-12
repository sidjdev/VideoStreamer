//
//  VideoStreamerUtils.swift
//  VideoStreamer
//
//  Created by Sidharth J Dev on 12/12/24.
//

import Foundation

class VideoStreamerUtils {
    /// Loads the VideosData.json file from the app bundle and decodes it into the VideosData model.
    static func loadVideosData() -> VideosData? {
        guard let url = Bundle.main.url(forResource: "VideosData", withExtension: "json") else {
            print("Failed to locate VideosData.json in bundle.")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            let videosData = try JSONDecoder().decode(VideosData.self, from: data)
            return videosData
        } catch {
            print("Failed to decode VideosData.json: \(error.localizedDescription)")
            return nil
        }
    }
}
