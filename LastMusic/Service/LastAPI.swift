//
//  LastAPI.swift
//  LastMusic
//
//  Created by mac on 5/21/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation


struct LastAPI {
    
    static let base = "http://ws.audioscrobbler.com/2.0/"
    
    static let artistMethod = "?method=artist.search&artist="
    static let albumMethod = "?method=artist.gettopalbums&artist="
    static let trackMethod = "?method=artist.gettoptracks&artist="
    
    static let key = "&api_key=43070dda2f585e51b62ead8380678e67&format=json"
    
    static func getArtistURL(_ artist: String, _ limit: Int) -> String {
        let newLimit = "&limit=\(limit)"
        return base + artistMethod + artist + newLimit + key
    }
    
    static func getAlbumURL(_ artist: String) -> String {
        return base + albumMethod + artist + key
    }
    
    static func getTrackURL(_ artist: String) -> String {
        return base + trackMethod + artist + key
    }
    
}
