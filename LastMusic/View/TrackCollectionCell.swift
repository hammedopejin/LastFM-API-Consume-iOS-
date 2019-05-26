//
//  TrackCollectionCell.swift
//  LastMusic
//
//  Created by mac on 5/23/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class TrackCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var trackAlbumImage: UIImageView!
    @IBOutlet weak var trackAlbumLabel: UILabel!
    
    
    static let identifier = "TrackCollectionCell"
    
    
    func configure(with album: Album) {
        
        trackAlbumLabel.text = album.name
        
        guard let url = Utility.getImageURL(from: album.image) else {
            trackAlbumImage.image = #imageLiteral(resourceName: "ph")
            return
        }
        
        
        dlManager.download(url) { [unowned self] dat in
            if let data = dat, let image = UIImage(data: data) {
                self.trackAlbumImage.image = image
            }
        }
    } //end func 
    
}
