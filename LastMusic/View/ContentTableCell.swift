//
//  ContentTableCell.swift
//  LastMusic
//
//  Created by mac on 5/21/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class ContentTableCell: UITableViewCell {
    
    @IBOutlet weak var contentImage: UIImageView!
    @IBOutlet weak var contentMainLabel: UILabel!
    @IBOutlet weak var contentSubLabel: UILabel!
    
    static let identifier = "ContentTableCell"
    
    func configure(with content: Content) {
        
        switch content {
        case .artist(let artist):
            
            contentMainLabel.text = artist.name
            contentSubLabel.text = "Listeners: \(artist.listeners.addCommas!)"
            
            guard let url = Utility.getImageURL(from: artist.image) else {
                contentImage.image = #imageLiteral(resourceName: "ph")
                return
            }
    
            dlManager.download(url) { [unowned self] dat in
                
                if let data = dat {
                    
                    let image = UIImage(data: data)
                    self.contentImage.image = image
                }
            }
            
        case .album(let album):
            
            contentMainLabel.text = album.name
            contentSubLabel.text = "Play Count: \(String(album.playCount).addCommas!)"
            
            guard let url = Utility.getImageURL(from: album.image) else {
                contentImage.image = #imageLiteral(resourceName: "ph")
                return
            }
            
            dlManager.download(url) { [unowned self] dat in
                
                if let data = dat {
                    
                    let image = UIImage(data: data)
                    self.contentImage.image = image
                }
            }
            
        case .track(let track):
            
            contentMainLabel.text = track.name
            contentSubLabel.text = "Play Count: \(track.playCount.addCommas!)"
            
            guard let url = Utility.getImageURL(from: track.image) else {
                contentImage.image = #imageLiteral(resourceName: "ph")
                return
            }
            
            dlManager.download(url) { [unowned self] dat in
                
                if let data = dat {
                    
                    let image = UIImage(data: data)
                    self.contentImage.image = image
                }
            }
        }
    } //end func
    
}
