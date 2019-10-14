//
//  CollectionName.swift
//  Collections
//
//  Created by Samantha Maxey on 10/10/19.
//  Copyright © 2019 Boise State. All rights reserved.
//

import UIKit

class CollectionName{
    //MARK: Properties
    
    var name: String
    
    //MARK: Initialization
    
    init?(name: String){
        if name.isEmpty{
            return nil
        }
        
        self.name = name
    }
}
