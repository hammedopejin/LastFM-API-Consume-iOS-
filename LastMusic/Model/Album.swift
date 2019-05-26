//
//  Album.swift
//  LastMusic
//
//  Created by mac on 5/22/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation


struct AlbumResponse: Decodable {
    
    let topAlbums: AlbumInfo
    
    private enum CodingKeys: String, CodingKey {
        case topAlbums = "topalbums"
    }
}

struct  AlbumInfo: Decodable {
    let album: [Album]
}

class Album: Decodable {
    
    let name: String
    let playCount: Int
    let image: [Image]
    
    private enum CodingKeys: String, CodingKey {
        case playCount = "playcount"
        case name
        case image
    }
}
