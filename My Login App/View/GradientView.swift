//
//  GridentView.swift
//  My Login App
//
//  Created by Tilakkumar Gondi on 07/07/19.
//  Copyright © 2019 Tilakkumar Gondi. All rights reserved.
//

import UIKit

@IBDesignable
class GradientView: UIView {
    
    @IBInspectable var Color1: UIColor = UIColor.white  {
        didSet {
            self.setGradient()
        }
    }
    
    @IBInspectable var Color2:UIColor = UIColor.white  {
        didSet {
            self.setGradient()
        }
    }
    
    @IBInspectable var GStart: CGPoint = .zero {
        didSet{
            self.setGradient()
        }
    }
    
    @IBInspectable var GEnd: CGPoint = CGPoint(x: 0, y: 1) {
        didSet{
            self.setGradient()
        }
    }
   
    private func setGradient()
    {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [self.Color1.cgColor, self.Color2.cgColor]
        gradientLayer.startPoint = self.GStart
        gradientLayer.endPoint = self.GEnd
        gradientLayer.frame = self.bounds
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }



}
