//
//  FBGraphRequest.swift
//  My Login App
//
//  Created by Tilakkumar Gondi on 07/07/19.
//  Copyright © 2019 Tilakkumar Gondi. All rights reserved.
//

import Foundation
import FacebookCore
import FacebookLogin
import FBSDKCoreKit
import FBSDKLoginKit


class FBGraphRequest: NSObject{
    
    func getUserDataFromFB(_ token: String, completion: @escaping (_ user:UserData?, _ error:Error?) -> Void) {
        
        
        let graphRequest:GraphRequest = GraphRequest(graphPath: "/me",
                                                     parameters: ["fields":"id, name,first_name,last_name,email,picture.type(large),birthday"],
                                                     tokenString: token,
                                                     version: nil,
                                                     httpMethod: .get)
        
        graphRequest.start { (response, result, error) in
            if error == nil {
                print(result as Any)
                guard let userProfile:[String:Any] = result as? [String:Any] else{
                    return
                }
                
                
                
                let picture:[String:Any] = userProfile["picture"] as! [String : Any]
                let data:[String:Any] = picture["data"] as! [String : Any]
                
                let user = UserData(first_name: (userProfile["first_name"] as! String),
                                    last_name: (userProfile["last_name"] as! String),
                                    phone: "",
                                    email: (userProfile["email"] as! String),
                                    date_of_birth: (userProfile["birthday"] as! String),
                                    dob: Utility.shared.getDateFromString((userProfile["birthday"] as! String)),
                                    password: (userProfile["id"] as! String),
                                    imageUrl: (data["url"] as! String))
                
                completion(user,error)
            }else{
                print(error?.localizedDescription as Any)
                completion(nil,error)
            }
        }
    }
    
    
}
