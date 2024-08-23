//
//  Keyboard.swift
//  AirlinesApplication
//
//  Created by HendEl-Mahdy on 24/08/2024.
//

import Foundation
import UIKit

extension UIViewController{
    
    func keyboardNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            if let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                let keyboardHeight = keyboardFrame.height
                adjustContentForKeyboard(show: true, keyboardHeight: keyboardHeight)
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        adjustContentForKeyboard(show: false, keyboardHeight: 0)
    }
    
    func adjustContentForKeyboard(show: Bool, keyboardHeight: CGFloat) {
        let adjustmentHeight = show ? keyboardHeight : 0
        view.frame.origin.y = -adjustmentHeight
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
