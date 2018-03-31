//
//  CardView.swift
//  FYP
//
//  Created by Sandeep Walia on 31/03/2018.
//  Copyright © 2018 Sandeep Walia. All rights reserved.
//

import UIKit

@IBDesignable class CardView: UIView {

    @IBInspectable var cornerRadius: CGFloat = 2
    
    @IBInspectable var shadowOffsetWidth: CGFloat = 0
    
    @IBInspectable var shadowOffsetHeight: CGFloat = 5
    
    @IBInspectable var shadowColor: UIColor = UIColor.black
    
    @IBInspectable var shadowOpacity: CGFloat = 0.5
    
    
    override func layoutSubviews() {
        
        layer.cornerRadius = cornerRadius
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
        
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        
        layer.shadowPath = shadowPath.cgPath
        layer.shadowOpacity = Float(shadowOpacity)
    }
    

}
