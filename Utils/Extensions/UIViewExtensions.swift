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
        layer.shadowOpacity = Float(Constants.UIViewExtensions_navigationShadow_Opacity)
        layer.shadowOffset = CGSize(width: Constants.UIViewExtensions_navigationShadow_widthOffset, height: Constants.UIViewExtensions_navigationShadow_heightOffset)
        layer.shadowRadius = CGFloat(Constants.UIViewExtensions_navigationShadow_radius)
        layer.masksToBounds = false
    }
    
    func detailedShadow(opacity:Float){
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = Float(Constants.UIViewExtensions_detailedShadow_Opacity)
        layer.shadowOffset = Constants.UIViewExtensions_detailedShadow_offset
        layer.shadowRadius =  CGFloat(Constants.UIViewExtensions_detailedShadow_radius)
        layer.masksToBounds = false
    }
    
    func addCornerRadius(cornerRadius: CGFloat){
        layer.cornerRadius = cornerRadius * self.bounds.size.width
        clipsToBounds = true
    }
}


