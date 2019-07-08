//
//  ViewController.swift
//  My Login App
//
//  Created by Tilakkumar Gondi on 05/07/19.
//  Copyright © 2019 Tilakkumar Gondi. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FacebookLogin
import FacebookCore


class LoginViewController: UIViewController {
    
    @IBOutlet weak var fbLoginButton: UIButton!
    @IBOutlet weak var emailLoginButton: UIButton!
    
    let fbGraphRequest = FBGraphRequest()
    let loginManager = LoginManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if AccessToken.current != nil {
            
            self.fbGraphRequest.getUserDataFromFB(AccessToken.current!.tokenString, completion: { [unowned self] (userData, error) in
                print(userData ?? "")
                
                guard let user = userData else {
                    print("Erro Fetching user data")
                    self.loginManager.logOut()
                    return
                }
                
               NavigationHelper.shared.goToUserProfileFrom(self, withUser: user)
            })
            print("Logged in!")
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    
    @IBAction func loginWithFacebook(_ sender: Any) {
        if AccessToken.current != nil
        {
            loginManager.logOut()
        }else{

            loginManager.logIn(permissions: [ .publicProfile, .email, .userGender, .userAboutMe ], viewController: self) { [unowned self] loginResult in
                switch loginResult {
                case .failed(let error):
                    print(error)
                case .cancelled:
                    print("User cancelled login.")
                case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                   
                    self.fbGraphRequest.getUserDataFromFB(AccessToken.current!.tokenString, completion: {[unowned self] (userData, error) in
                        print(userData ?? "")

                        guard let user = userData else {
                            print("Erro Fetching user data from FBGrapAPI")
                            self.loginManager.logOut()
                            return
                        }
                        NavigationHelper.shared.goToUserProfileFrom(self, withUser: user)
                    })
                    print("Logged in!")
                }
            }
        }
    }

   

}

