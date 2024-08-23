//
//  UIViewExtensions.swift
//  AirlinesApplication
//
//  Created by HendEl-Mahdy on 20/07/2024.
//
import Foundation
import UIKit

extension UIView{
    
    func round(radius: CGFloat){
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
    func addBorder(color: UIColor, width: CGFloat){
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
    
    func navigationShadow(opacity:Float) {
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 2
        layer.masksToBounds = false
    }
    
    func detailedShadow(opacity:Float){
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = .zero 
        layer.shadowRadius =  2
        layer.masksToBounds = false
    }
    
    func addCornerRadius(cornerRadius: CGFloat){
        layer.cornerRadius = cornerRadius * self.bounds.size.width
        clipsToBounds = true
    }
}


