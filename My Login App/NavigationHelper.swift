//
//  NavigationHelper.swift
//  My Login App
//
//  Created by Tilakkumar Gondi on 08/07/19.
//  Copyright © 2019 Tilakkumar Gondi. All rights reserved.
//

import Foundation
import UIKit

class NavigationHelper: NSObject {
    fileprivate let storyBord = UIStoryboard.init(name: "Main", bundle: nil)
    
    static let shared = NavigationHelper()
    
    func goToUserProfileFrom(_ controller:UIViewController,withUser data:UserData)  {
        let profileVC:UserViewController = storyBord.instantiateViewController(withIdentifier: "ProfileVC") as! UserViewController
        profileVC.userData = data
        controller.navigationController?.present(profileVC, animated: true, completion: nil)
        
    }
}
