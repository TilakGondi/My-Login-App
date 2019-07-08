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
    @IBOutlet weak var userTableView: UITableView!
    @IBOutlet weak var lblWelcome: UILabel!
    
    var userData:UserData?
    
    fileprivate let placeHolders = ["First name","Last name","Date of birth","Email Id","Phone number"]
    fileprivate var values:[String] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.userImage.layer.cornerRadius = self.userImage.frame.width / 2
        
      
       self.lblWelcome.text = "Welcome \(userData!.first_name ?? "") !"
        
        values = [userData?.first_name,userData?.last_name ?? "",userData?.date_of_birth ?? "",userData?.email ?? "",userData?.phone ?? ""] as! [String]
        
       
        if let url = URL(string: userData?.imageUrl ?? "") {
                let session:URLSession = .shared
                let task = session.dataTask(with: url) { (imageData, _, error) in
                    
                    guard let imageData = imageData, let image = UIImage(data: imageData) else {
                        return
                    }
                    DispatchQueue.main.async {
                        self.userImage.image = image
                    }
                }
                task.resume()
            }
    }
    
    
    @IBAction func logOutAction(_ sender: Any) {
        
        if AccessToken.current != nil
        {
            let loginManager = LoginManager()
            loginManager.logOut()
        }
        self.dismiss(animated: true, completion: nil)
    }
}


// MARK: - <#UITableViewDelegate,UITableViewDataSource#>
extension UserViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeHolders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TextFieldTableViewCell  = tableView.dequeueReusableCell(withIdentifier: "cell") as! TextFieldTableViewCell
        cell.txtPlaceHolder.text = placeHolders[indexPath.row]
        cell.txtDataValue.text = values[indexPath.row]
        return cell
    }
    
}
