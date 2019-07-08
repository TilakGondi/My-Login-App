//
//  Utility.swift
//  My Login App
//
//  Created by Tilakkumar Gondi on 08/07/19.
//  Copyright © 2019 Tilakkumar Gondi. All rights reserved.
//

import Foundation
import UIKit

enum AlertType:Int {
    case InfoAlert=0,ConfirmAlert
}


class Utility: NSObject {
    
    static let shared = Utility()
    let df:DateFormatter!
    
    override init() {
        df = DateFormatter()
        df.dateFormat = "dd/MM/yyyy"
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

    func getDateFromString(_ dateStr:String) -> Date {
        return df.date(from: dateStr)!
    }
    
    func getStringFromDate(_ date:Date) -> String {
        return df.string(from: date)
    }
    
}
