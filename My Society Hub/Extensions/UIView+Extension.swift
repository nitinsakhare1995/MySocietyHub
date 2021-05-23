//
//  UIView+Extension.swift
//  My Society Hub
//
//  Created by Nitin Sakhare on 21/05/21.
//

import UIKit

@IBDesignable extension UIView {
    @IBInspectable var borderColor: UIColor? {
        set {
            layer.borderColor = newValue?.cgColor
        }
        get {
            guard let color = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: color)
        }
    }
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
        get {
            return layer.cornerRadius
        }
    }
    
    func rotate(degrees: CGFloat) {
        rotate(radians: CGFloat.pi * degrees / 180.0)
    }
    
    func rotate(radians: CGFloat) {
        self.transform = CGAffineTransform(rotationAngle: radians)
    }
    
    func dropShadow() {
        layer.shadowColor = UIColor.lightGray.withAlphaComponent(0.6).cgColor
        layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: 0.0 , height: 0.2)
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 1.0
    }
    
}
