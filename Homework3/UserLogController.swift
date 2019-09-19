//
//  UserLogController.swift
//  Homework2
//
//  Created by Samantha Maxey on 9/19/19.
//  Copyright © 2019 Boise State. All rights reserved.
//

import UIKit

class UserLogController: NSObject {
    
    static var loggingArray = Array<String>()
    
    class func loggingList() -> Array<String>{
        
        return UserLogController.loggingArray
    }
    
    
    static func logNewEvent(newEventToLog:String){
        
        UserLogController.loggingArray.append(newEventToLog)
        
        //prints contents of array to the console
        print(UserLogController.loggingArray)
    }
    

}
