//
//  Artist.swift
//  LastMusic
//
//  Created by mac on 5/21/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation

struct ArtistResults: Decodable {
    let results: ArtistMatches
}

struct ArtistMatches: Decodable {
    let artistmatches: ArtistInfo
}

struct ArtistInfo: Decodable {
    let artist: [Artist]
}

class Artist: Decodable {
    
    let name: String
    let listeners: String
    let url: String
    let image: [Image]
    
}

struct Image: Decodable {
    
    let text: String
    let size: String
    
    private enum CodingKeys: String, CodingKey {
        case text = "#text"
        case size 
    }
}


