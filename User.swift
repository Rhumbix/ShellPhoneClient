//
//  User.swift
//  Shellphone
//
//  Created by Majd Murad on 11/15/15.
//  Copyright © 2015 sandness. All rights reserved.
//

import Foundation
import SwiftyJSON

class User: NSObject {
    var username:String?
    var phoneNumber:Int?
    var id:Int?
    
    init( withDict jsonData:JSON) {
        //        let jsonUser = JSON(jsonData)
        
        self.username = (jsonData["username"]).string!
        self.phoneNumber = (jsonData["phone_number"]).int!
        self.id = (jsonData["id"]).int!
    }
}