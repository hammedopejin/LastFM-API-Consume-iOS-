//
//  LastService.swift
//  LastMusic
//
//  Created by mac on 5/21/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation

typealias ArtistHandler = ([Artist]) -> Void
typealias AlbumHandler = ([Album]) -> Void
typealias TrackHandler = ([Track]) -> Void

let lsService = LastService.shared

final class LastService {
    
    static let shared = LastService()
    private init() {}
    
    lazy var session: URLSession = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        return URLSession(configuration: config)
    }()
    
    
    //MARK: Artist
    func get(artist: String, completion: @escaping ArtistHandler) {
        
        var limit = 30
        if let artistsCount = UserDefaults.standard.value(forKey: Constants.Keys.artistsCount.rawValue) as? Int {
            limit = artistsCount
        }
        
        let urlString = LastAPI.getArtistURL(artist, limit)
        
        guard let finalURL = URL(string: urlString) else {
            completion([])
            return
        }
        
        session.dataTask(with: finalURL) { (dat, _, _) in
            
            if let data = dat {
                
                do {
                    let response = try JSONDecoder().decode(ArtistResults.self, from: data)
                    
                    let artists = response.results.artistmatches.artist
                    
                    completion(artists)
                    
                } catch let err {
                    completion([])
                    print("Decoding Error: \(err.localizedDescription)")
                }
                
            }
            
        }.resume()
        
    } //end func
    
    
    //MARK: Album
    
    func getAlbums(for artist: String, completion: @escaping AlbumHandler) {
        
        let urlString = LastAPI.getAlbumURL(artist)
        
        guard let finalURL = URL(string: urlString) else {
            completion([])
            return
        }
        
        session.dataTask(with: finalURL) { (dat, _, _) in
            
            if let data = dat {
                
                do {
                    let response = try JSONDecoder().decode(AlbumResponse.self, from: data)
                    
                    let albums = response.topAlbums.album
                    
                    completion(albums)
                    
                } catch let err {
                    completion([])
                    print("Decoding Error: \(err.localizedDescription)")
                }
                
            }
            
            }.resume()
        
    } //end func
    
    
    //MARK: Track
    func getTracks(for artist: String, completion: @escaping TrackHandler) {
        
        let urlString = LastAPI.getTrackURL(artist)
        
        guard let url = URL(string: urlString) else {
            completion([])
            return
        }
        
        
        session.dataTask(with: url) { (dat, _, _) in
            
            if let data = dat {
                
                do {
                    let result = try JSONDecoder().decode(TrackResult.self, from: data)
                    let tracks = result.toptracks.track
                    completion(tracks)
                } catch {
                    
                    completion([])
                    print("Decode Error: \(error.localizedDescription)")
                    return
                }
            
            }
        }.resume()
        
    }
    
    
    
}
