//
//  View+Ex.swift
//  My-Property-iOS
//
//  Created by Ngoun Lyborey on 5/6/23.
//

import UIKit

extension UIView {
    public static var id: String {
        get {
            return "\(self)"
        }
    }
    
    public static var nib: UINib {
        get {
            return UINib(nibName: "\(self)", bundle: nil)
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {return self.cornerRadius}
         set {
             self.layer.cornerRadius = newValue
         }
     }
    
    func addTopCornerRadius(radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: [.topLeft, .topRight],
                                cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        layer.mask = maskLayer
        layer.masksToBounds = true
    }
    
    func addTopRightRadius(radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: [.topRight],
                                cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        layer.mask = maskLayer
        layer.masksToBounds = true
    }
    
    func addTopLeftRadius(radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: [.topLeft],
                                cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        layer.mask = maskLayer
        layer.masksToBounds = true
    }
}
