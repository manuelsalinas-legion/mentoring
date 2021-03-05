//
//  UIView+Extension.swift
//  FutballTournaments
//
//  Created by bts on 26/02/21.
//

import Foundation
import UIKit

extension UIView {
    func addBorder(color: UIColor = .black, borderWidth: CGFloat = 1) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.shadowRadius = 2
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
    }
    
    func addCornerRadious(radious: CGFloat) {
        self.layer.cornerRadius = radious
        self.clipsToBounds = true
    }
    
    func addShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: 3.5, height: 3.5)
        self.layer.shadowRadius = 1
        self.layer.masksToBounds = false
    }
    
    func rounded() {
        self.layer.cornerRadius =  (self.bounds.width / 2)
        self.clipsToBounds = true
    }
    
    /// Set border and rounded in a sme function
    func applyAll() {
        addBorder()
        rounded()
    }
}
