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

struct ResponseData: Decodable {
    /*
     {
     birthday = "07/10/2000";
     email = "decrxtbjkv_1562439492@tfbnw.net";
     "first_name" = Betty;
     id = 106590817314453;
     "last_name" = Fergieberg;
     name = "Betty Alchijfjehdch Fergieberg";
     picture =     {
     data =         {
     height = 200;
     "is_silhouette" = 0;
     url = "https://platform-lookaside.fbsbx.com/platform/profilepic/?asid=106590817314453&height=200&width=200&ext=1565049595&hash=AeRcnyQgfo_dOGhb";
     width = 200;
     };
     };
     }
     */
    
    let birthday: String
    let email: String
    let first_name: String
    let id: String
    let last_name: String
    let name: String
    let picture:data
    
}

struct data: Decodable {
    let height: Int
    let width: Int
    let is_silhouette: Bool
    let url: String
}

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
                print(userProfile["name"]!)
                
                let df = DateFormatter()
                df.dateFormat = "dd/MM/yyyy"
                
                let picture:[String:Any] = userProfile["picture"] as! [String : Any]
                let data:[String:Any] = picture["data"] as! [String : Any]
                
                let user = UserData(first_name: (userProfile["first_name"] as! String),
                                    last_name: (userProfile["last_name"] as! String),
                                    phone: "2343242345245",
                                    email: (userProfile["email"] as! String),
                                    date_of_birth: (userProfile["birthday"] as! String),
                                    dob: df.date(from: (userProfile["birthday"] as! String))!,
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
