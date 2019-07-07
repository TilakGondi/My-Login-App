//
//  SignUpViewController.swift
//  My Login App
//
//  Created by Tilakkumar Gondi on 07/07/19.
//  Copyright © 2019 Tilakkumar Gondi. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtDOB: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtCnfmPassword: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func signUpAction(_ sender: Any) {
        let df = DateFormatter()
        df.dateFormat = "dd/MM/yyyy"
        
        
        let userInfo = UserData(first_name: self.txtFirstName.text,
                                last_name: self.txtLastName.text,
                                phone: self.txtPhone.text,
                                email: txtEmail.text,
                                date_of_birth: self.txtDOB.text,
                                dob: df.date(from: self.txtDOB.text!)!,
                                password: self.txtCnfmPassword.text,
                                imageUrl: "")
        
        DBManager.shared.saveUser(data: userInfo)
        self.navigationController?.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func cancelAction(_ sender: Any) {
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
