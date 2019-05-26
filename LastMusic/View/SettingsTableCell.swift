//
//  SettingsTableCellTwo.swift
//  LastMusic
//
//  Created by mac on 5/24/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class SettingsTableCell: UITableViewCell {
    @IBOutlet weak var infoImage: UIImageView!
    @IBOutlet weak var infoLabel: UILabel!
    
    static let identifier = "SettingsTableCell"
    
    func config(with name: String) {
        infoLabel.text = name
        infoImage.image = UIImage(named: name)!
    }
}
