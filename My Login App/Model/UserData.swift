//
//  UserData.swift
//  My Login App
//
//  Created by Tilakkumar Gondi on 07/07/19.
//  Copyright © 2019 Tilakkumar Gondi. All rights reserved.
//

import Foundation
import FacebookCore
import FBSDKLoginKit
import FacebookLogin

struct UserData {
    
    var first_name: String?
    var last_name: String?
    var phone: String?
    var email: String?
    var date_of_birth: String?
    var dob: Date {
        didSet{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            self.date_of_birth = dateFormatter.string(from: dob)
        }
    }
    var password: String?
    
    var imageUrl: String?
    
    
}
