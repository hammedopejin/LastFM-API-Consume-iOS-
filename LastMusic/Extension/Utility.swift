//
//  Utility.swift
//  LastMusic
//
//  Created by mac on 5/23/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation


struct Utility {
    
    //MARK: FileManager
    static private let fileManager = FileManager.default
    
    //MARK: Save FM
    static func saveWithFileManager(_ data: Data) {
        
        let hash = String(data.hashValue)
        
        guard let url = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(hash) else {
            
            print("Error with file system")
            return
        }
        
        do {
             try data.write(to: url)
            print("Successfully wrote data to disk")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    //MARK: Load FM
    static func loadWithFileManager(_ hashValue: String) -> URL? {
        
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let userDomain = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomain, true)
        
        if let dirPath = paths.first {
            
            let url = URL(fileURLWithPath: dirPath).appendingPathComponent(hashValue)
            
            return url
        }
        
        return nil
    }
    
    //MARK: Helpers
    static func getImageURL(from images: [Image]) -> String? {
        
        guard let img = images.first(where: {$0.size == "extralarge"}) else {
            return nil
        }
        
        return img.text
    }

}
