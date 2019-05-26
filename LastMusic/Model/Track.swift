//
//  Track.swift
//  LastMusic
//
//  Created by mac on 5/23/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation

struct TrackResult: Decodable {
    let toptracks: TrackInfo
}

struct TrackInfo: Decodable {
    let track: [Track]
}

class Track: Decodable {
    
    let name: String
    let playCount: String
    let url: String
    let image: [Image]
    
    private enum CodingKeys: String, CodingKey {
        case name
        case playCount = "playcount"
        case url
        case image
    }
}
