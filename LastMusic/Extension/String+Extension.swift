//
//  String+Extension.swift
//  LastMusic
//
//  Created by mac on 5/22/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation


extension String {
    
    var addCommas: String? {
        
        guard let number = Int(self) else {
            return nil
            
        }
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: number as NSNumber)
        
    }
}
