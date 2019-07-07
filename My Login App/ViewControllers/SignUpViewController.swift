//
//  SignUpViewController.swift
//  My Login App
//
//  Created by Tilakkumar Gondi on 07/07/19.
//  Copyright © 2019 Tilakkumar Gondi. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    

    @IBOutlet weak var signUpTableView: UITableView!
    @IBOutlet weak var tableViewBottomAnchor: NSLayoutConstraint!
    

    fileprivate var placeHolders = ["First name","Last name", "Date of birth", "Phone number", "Email Id", "Password", "Confirm password"]
    
    fileprivate var values = ["","","","","","",""]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.signUpTableView.isScrollEnabled = true
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func signUpAction(_ sender: Any) {
        
        if self.validateAndSignUp() {
            
            self.show(Alert: .InfoAlert, title: "Signup success", message: "You have been successfully signed up. Please login.", onController: self)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.dismiss(animated: true, completion: nil)
            }
            
        }else{
            self.show(Alert: .InfoAlert, title: "Signup failed", message: "Failed to signup, please check the values you have entered and try again.", onController: self)
            return
        }
        
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}


// MARK: - <#UITableViewDelegate,UITableViewDataSource#> extension on signupviewcontroller
extension SignUpViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeHolders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TextFieldTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TextFieldTableViewCell
        cell.txtCellField.placeholder = placeHolders[indexPath.row]
        cell.txtCellField.tag = indexPath.row
        cell.txtCellField.text = values[indexPath.row]
        
        if placeHolders[indexPath.row].contains("password") || placeHolders[indexPath.row].contains("Password")  {
            cell.txtCellField.isSecureTextEntry = true
        }else{
            cell.txtCellField.isSecureTextEntry = false
        }
        
        if placeHolders[indexPath.row].contains("Phone number") {
            cell.txtCellField.keyboardType = .phonePad
        }else{
            cell.txtCellField.keyboardType = .asciiCapable
        }
        
        return cell
    }
    
}


// MARK: - <#UITextFieldDelegate#> extension on signupviewcontroller
extension SignUpViewController:UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1
        // Try to find next responder
        let nextResponder = textField.superview?.superview?.superview?.superview?.viewWithTag(nextTag)
        
        if nextResponder != nil {
            // Found next responder, so set it
            nextResponder?.becomeFirstResponder()
            if self.tableViewBottomAnchor.constant < 200{
                self.tableViewBottomAnchor.constant = 200
                self.view.updateConstraints()
            }
        } else {
            // Not found, so remove keyboard
            textField.resignFirstResponder()
            if self.tableViewBottomAnchor.constant > 10 {
                self.tableViewBottomAnchor.constant = 10
                self.view.updateConstraints()
            }
        }
        
        if let cell = textField.superview?.superview as? TextFieldTableViewCell,let path = signUpTableView.indexPath(for: cell){
            self.signUpTableView.scrollToRow(at: path, at: .top, animated: true)
        }
        
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let cell = textField.superview?.superview as? TextFieldTableViewCell,let path = signUpTableView.indexPath(for: cell) {
            if textField.text != nil || textField.text == ""{
                    values[path.row] = cell.txtCellField.text ?? ""
            }
            
        }
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if self.tableViewBottomAnchor.constant < 200{
            self.tableViewBottomAnchor.constant = 200
            self.view.updateConstraints()
        }
    }
    
    
}

enum AlertType:Int {
    case InfoAlert=0,ConfirmAlert
}

extension SignUpViewController {
    
    func validateAndSignUp() -> Bool {
        var result:Bool = false
        
        
        
        let df = DateFormatter()
        df.dateFormat = "dd/MM/yyyy"
        
        
        if !self.isEmpty(string: values[0]) {
            result = true
        }else{
            
            result = false
        }
        
        if !self.isEmpty(string: values[1]) {
            result = true
        }else{
            result = false
        }
        
        if !self.isEmpty(string: values[2]) {
            result = true
        }else{
            result = false
        }
        
        if !self.isEmpty(string: values[3]) {
            result = true
        }else{
            result = false
        }
        
        
        if !self.isEmpty(string: values[4]) {
            if !self.isValidEmail(email: values[4]){
                self.show(Alert: .InfoAlert, title: "Error", message: "Please enter valid email.", onController: self)
                result = false
            }else{
                result = true
            }
        }else{
            result = false
        }
        
        if !self.isEmpty(string: values[5]) && !self.isEmpty(string: values[6]) {
            
            if values[5] == values[6] {
                result = true
            }else{
                self.show(Alert: .InfoAlert, title: "Error", message: "Passwords do not match.", onController: self)
                result = false
            }
        }else{
            result = false
        }
        
        
        
        
        if result {
            let userInfo = UserData(first_name: values[0],
                                    last_name: values[1],
                                    phone: values[3],
                                    email: values[4],
                                    date_of_birth: values[2],
                                    dob: df.date(from: values[2])!,
                                    password: values[6],
                                    imageUrl: "")
            DBManager.shared.saveUser(data: userInfo)
            
        }
        
        
        return result
    }
    
    func show(Alert type:AlertType,title t:String,message m:String,onSuccess s:(()-> Void)? = nil,
              onFailure f:(() -> Void)? = nil,onController c:UIViewController?,confirmTitles:[String]? = nil) {
        if c != nil {
            let alert = UIAlertController(title: t, message: m, preferredStyle: .alert)
            if type == .InfoAlert {
                if let ttl = confirmTitles {
                    alert.addAction(UIAlertAction(title: ttl[0], style: .default, handler: nil))
                } else {
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (act) in
                        if let closure = s {
                            closure()
                        }
                    }))
                }
            } else if type == .ConfirmAlert {
                if let ttl = confirmTitles {
                    alert.addAction(UIAlertAction(title: ttl[0], style: .cancel, handler: { (act) in
                        if let closure = f {
                            closure()
                        }
                    }))
                    alert.addAction(UIAlertAction(title: ttl[1], style: .default, handler: { (act) in
                        if let closure = s {
                            closure()
                        }
                    }))
                }
            }
            c!.present(alert, animated: true, completion: nil)
        }
    }
    
    
    func isEmpty(string s:String?) -> Bool {
        guard let val = s else {
            return true
        }
        return val.isEmpty
    }
    
    func isValidEmail(email:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
}

