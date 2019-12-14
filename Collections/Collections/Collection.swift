//
//  Collection.swift
//  Collections
//
//  Created by Samantha Maxey on 10/8/19.
//  Copyright © 2019 Boise State. All rights reserved.
//

import UIKit
import os.log

class Collection: NSObject, NSCoding {
    
    //MARK: Properties
    
    var title: String
    var author: String
    var year: Int
    var photo: UIImage?
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("collections")
    
    //MARK: Types
    struct PropertyKey{
        static let title = "title"
        static let author = "author"
        static let year = "year"
        static let photo = "photo"
        
    }
    
    // MARK: Initialization
    
    init?(title: String, author: String, year: Int,
         photo: UIImage?){
    
        guard !title.isEmpty else{
            return nil
        }
        
        guard !author.isEmpty else{
            return nil
        }
        
        guard (year >= 1900) && (year <= 2025) else{
            return nil
        }
        
        self.title = title
        self.author = author
        self.year = year
        self.photo = photo
    }
    var titleFirstLetter: String {
       
        return String(self.title[self.title.startIndex]).uppercased()
    }
    //MARK: NSCoding
    func encode(with aCoder: NSCoder){
        aCoder.encode(title, forKey: PropertyKey.title)
        aCoder.encode(author, forKey: PropertyKey.author)
        aCoder.encode(year, forKey: PropertyKey.year)
        aCoder.encode(photo, forKey: PropertyKey.photo)
    }
    
    required convenience init?(coder aDecoder: NSCoder){
        //The name is required. If we cannot decode a name string, the initializer should fail
        
        guard let title = aDecoder.decodeObject(forKey: PropertyKey.title) as? String else{
            os_log("Unable to decode the name for a Collection object", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let author = aDecoder.decodeObject(forKey: PropertyKey.author) as? String else{
            os_log("Unable to decode the name for a Collection object", log: OSLog.default, type: .debug)
            return nil
        }
        
        let year = aDecoder.decodeInteger( forKey: PropertyKey.year)
        
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        
        //Must call designated initializer
        self.init(title: title, author: author, year: year, photo: photo)
       
    }
   
}

