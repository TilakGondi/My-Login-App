//
//  UserViewController.swift
//  My Login App
//
//  Created by Tilakkumar Gondi on 07/07/19.
//  Copyright © 2019 Tilakkumar Gondi. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import FBSDKLoginKit

class UserViewController: UIViewController {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var dateOfbirth: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var logOutButton: UIButton!
    
    var userData:UserData?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.userImage.layer.cornerRadius = self.userImage.frame.width / 2
        
        self.firstName.text = userData?.first_name
        self.lastName.text = userData?.last_name
        self.dateOfbirth.text = userData?.date_of_birth
        self.email.text = userData?.email
        self.phone.text = userData?.phone
        
        let session:URLSession = .shared
        let task = session.dataTask(with: URL(string: userData!.imageUrl!)!) { (imageData, _, error) in
            
            guard let imageData = imageData, let image = UIImage(data: imageData) else {
                return
            }
            DispatchQueue.main.async {
                self.userImage.image = image
            }
            
            
        }
        task.resume()
    }
    
    
    @IBAction func logOutAction(_ sender: Any) {
        
        if AccessToken.current != nil
        {
            let loginManager = LoginManager()
            loginManager.logOut()
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
