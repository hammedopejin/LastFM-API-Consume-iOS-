//
//  ViewModel.swift
//  LastMusic
//
//  Created by mac on 5/21/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation


class ViewModel {
    
    var artists = [Artist]() {
        didSet {
            NotificationCenter.default.post(name: Notification.Name.ArtistNotification, object: nil)
        }
    }
    
    var albums = [Album]() {
        didSet {
            NotificationCenter.default.post(name: Notification.Name.AlbumNotification, object: nil)
        }
    }
    
    var tracks = [Track]() {
        didSet {
            
            NotificationCenter.default.post(name: Notification.Name.TrackNotification, object: nil)
            
        }
    }
    
    var currentArtist: Artist!
    
    //MARK: Service
    
    func getArtists(with search: String) {
        
        lsService.get(artist: search) { [unowned self] artists in
           self.artists = artists
            print("Artist Count: \(self.artists.count)")
        }
    }
    
    func getAlbums(by artist: Artist) {
        
        guard let artistName = artist.name.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            return
        }
        
        lsService.getAlbums(for:artistName) { [unowned self] albums in
            self.albums = albums
            print("Album Count: \(self.albums.count)")
        }
    }
    
    func getTracks(by artist: Artist) {
        
        guard let artistName = artist.name.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            return
        }
        
        lsService.getTracks(for: artistName) { [unowned self] tracks in
            self.tracks = tracks
            print("Track Count: \(self.tracks.count)")
        }
    }
    
    
}
