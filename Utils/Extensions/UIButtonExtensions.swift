//
//  UIButtonExtensions.swift
//  AirlinesApplication
//
//  Created by HendEl-Mahdy on 25/07/2024.
//

import Foundation
import UIKit

extension UIButton{
    
    func redCircleButton(cornerRadius: CGFloat, shadowRadius: CGFloat, shadowOpacity: Float){
        layer.cornerRadius = cornerRadius * self.bounds.size.width
        clipsToBounds = true
        layer.shadowColor = UIColor.red.cgColor
        layer.masksToBounds = false
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
    }
    
}
