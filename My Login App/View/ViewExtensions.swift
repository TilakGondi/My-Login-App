//
//  ViewExtensions.swift
//  My Login App
//
//  Created by Tilakkumar Gondi on 07/07/19.
//  Copyright © 2019 Tilakkumar Gondi. All rights reserved.
//

import Foundation
import UIKit



// MARK: - UITextField extension to add cornerRadius, borderColor, left and right padding
@IBDesignable
extension UITextField {
    func prepareBorderField() {
        self.clipsToBounds = true
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 1
    }
    
    open override func awakeFromNib() {
        self.returnKeyType = .next
        self.layer.cornerRadius = self.cornerRadius
        
        
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get{
            return self.layer.cornerRadius
        }
        set{
            self.layer.cornerRadius = newValue
        }
        
    }
    
    @IBInspectable var paddingLeftCustom: CGFloat {
        get {
            self.returnKeyType = .next
            return leftView!.frame.size.width
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            self.leftView = paddingView
            self.leftViewMode = .always
        }
        
    }
    
    @IBInspectable var paddingRightCustom: CGFloat {
        get {
            return rightView!.frame.size.width
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            self.rightView = paddingView
            self.rightViewMode = .always
        }
    }
}


// MARK: - UIButton extension to add corner radius from storyboard
@IBDesignable
extension UIButton {
    @IBInspectable var cornerRadius: CGFloat {
        get{
            return self.layer.cornerRadius
        }
        set{
            self.layer.cornerRadius = newValue
        }
        
    }
}
