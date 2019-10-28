//
//  CollectionName.swift
//  Collections
//
//  Created by Samantha Maxey on 10/10/19.
//  Copyright © 2019 Boise State. All rights reserved.
//

import UIKit
import os.log

class CollectionName: NSObject, NSCoding{
    //MARK: Properties
    
    var name: String
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("names")
    
    //MARK: Types
    
    struct PropertyKey{
        static let name = "name"
    }
    
    //MARK: Initialization
    
    init?(name: String){
        if name.isEmpty{
            return nil
        }
        
        self.name = name
    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder){
        aCoder.encode(name, forKey: PropertyKey.name)
    }
    
    required convenience init?(coder aDecoder: NSCoder){
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else{
            os_log("Unable to decode the name for a Collection Name", log: OSLog.default, type: .debug)
            return nil
        }
        
        self.init(name: name)
    }
    
}
