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
    //jwvxggejud_1562439493@tfbnw.net
    
    @IBOutlet weak var fbLoginButton: UIButton!
    @IBOutlet weak var emailLoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
       
    }
    
    
    @IBAction func loginWithFacebook(_ sender: Any) {
        
        let loginManager = LoginManager()
        if AccessToken.current != nil
        {
            loginManager.logOut()
        }else{
            
            loginManager.logIn(permissions: [ .publicProfile, .email, .userGender, .userAboutMe ], viewController: self) { loginResult in
                switch loginResult {
                case .failed(let error):
                    print(error)
                case .cancelled:
                    print("User cancelled login.")
                case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                    print(accessToken)
                    print(grantedPermissions)
                    print(declinedPermissions)
                    let fbGraphRequest = FBGraphRequest()
                    fbGraphRequest.getUserDataFromFB(AccessToken.current!.tokenString, completion: { (userData, error) in
                        print(userData ?? "")
                        
                        guard let user = userData else {
                            print("Erro Fetching user data")
                            loginManager.logOut()
                            return
                        }
                        
                        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
                        let profileView:UserViewController = storyBoard.instantiateViewController(withIdentifier: "ProfileVC") as! UserViewController
                        profileView.userData = user
                        self.navigationController?.present(profileView, animated: true, completion: nil)
                    })
                    print("Logged in!")
                }
            }
            
            
        }
       
        
    }

    func getUserDataFromFb(){
        let graphRequest:GraphRequest = GraphRequest(graphPath: "/me", parameters: ["fields":"id, name,first_name,last_name,email,picture.type(large),birthday"], httpMethod: .get)
        
        graphRequest.start { (response, result, error) in
            if error == nil {
                print(result as Any)
            }else{
                print(error?.localizedDescription as Any)
            }
        }
    }

}



