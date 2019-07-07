//
//  EmailLoginViewController.swift
//  My Login App
//
//  Created by Tilakkumar Gondi on 07/07/19.
//  Copyright © 2019 Tilakkumar Gondi. All rights reserved.
//

import UIKit

class EmailLoginViewController: UIViewController {

  
    @IBOutlet weak var loginTableView: UITableView!
    
    fileprivate var placeHolders = ["yourname@example.com","Password"]
    fileprivate var values = ["",""]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func loginAction(_ sender: Any) {
        guard let user:UserData = (DBManager.shared.fetchUserWith(emailId: values[0], password: values[1])) else{
            return
        }
        print(user.first_name as Any)
        
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let profileView:UserViewController = storyBoard.instantiateViewController(withIdentifier: "ProfileVC") as! UserViewController
        profileView.userData = user
        self.navigationController?.present(profileView, animated: true, completion: nil)
        
        
       
    }
    
    

}


extension EmailLoginViewController:UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeHolders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TextFieldTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TextFieldTableViewCell
        cell.txtCellField.placeholder = placeHolders[indexPath.row]
        cell.txtCellField.tag = indexPath.row
        if indexPath.row == 1 {
            cell.txtCellField.isSecureTextEntry = true
        }
        return cell
    }
}


// MARK: - <#UITextFieldDelegate#> extension on signupviewcontroller
extension EmailLoginViewController:UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1
        // Try to find next responder
        let nextResponder = textField.superview?.superview?.superview?.superview?.viewWithTag(nextTag)
        
        if nextResponder != nil {
            // Found next responder, so set it
            nextResponder?.becomeFirstResponder()
            
        } else {
            // Not found, so remove keyboard
            textField.resignFirstResponder()
           
        }
        
        if let cell = textField.superview?.superview as? TextFieldTableViewCell,let path = loginTableView.indexPath(for: cell){
            self.loginTableView.scrollToRow(at: path, at: .top, animated: true)
        }
        
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let cell = textField.superview?.superview as? TextFieldTableViewCell,let path = loginTableView.indexPath(for: cell) {
            if textField.text != nil || textField.text == ""{
                values[path.row] = cell.txtCellField.text ?? ""
            }
            
        }
        
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if  textField.tag == 1{
            //            textField.resignFirstResponder()
            textField.isSecureTextEntry = true
            
        }
    }
}
