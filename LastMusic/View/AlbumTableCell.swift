//
//  AlbumTableCell.swift
//  LastMusic
//
//  Created by mac on 5/22/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class AlbumTableCell: UITableViewCell {

    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var albumMainLabel: UILabel!
    @IBOutlet weak var albumSubLabel: UILabel!
    
    static let identifier = "AlbumCell"
    
    
    func configureTable(with artist: Artist) {
        
        albumMainLabel.text = artist.name
        albumSubLabel.text = "Listeners: \(artist.listeners.addCommas!)"
        
        guard let url = Utility.getImageURL(from: artist.image) else {
            albumImage.image = #imageLiteral(resourceName: "ph")
            return
        }
        
        dlManager.download(url) { [unowned self] dat in
            
            if let data = dat, let image = UIImage(data: data) {
                
                self.albumImage.image = image
            }
        }
        
        
        
    }

}
