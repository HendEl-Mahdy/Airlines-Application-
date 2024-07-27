//
//  TextFieldValidation.swift
//  AirlinesApplication
//
//  Created by admin user on 25/07/2024.
//

import Foundation
import UIKit

class TextFieldValidation: UITextField{
    
    func validateInputData(_ name: UITextField, _ website: UITextField,
                           _ nameLabel: UILabel, _ websiteLabel: UILabel ) -> Int{
        
        if name.text == Constants.emptyString && !website.text!.contains(Constants.validURL){
            textFieldReset(name, nameLabel)
            textFieldReset(website, websiteLabel)
            validationError(name, nameLabel)
            validationError(website, websiteLabel)
            return 0
        }
        else if name.text != Constants.emptyString && !website.text!.contains(Constants.validURL){
            textFieldReset(name, nameLabel)
            textFieldReset(website, websiteLabel)
            validationError(website, websiteLabel)
            return 1
        }
        else if name.text == Constants.emptyString && website.text!.contains(Constants.validURL){
            textFieldReset(name, nameLabel)
            textFieldReset(website, websiteLabel)
            validationError(name, nameLabel)
            return 2
        }
        else{
            textFieldReset(name, nameLabel)
            textFieldReset(website, websiteLabel)
            return 3
        }
    }
    
    func validationError(_ textfield: UITextField, _ errorLabel: UILabel){
        errorLabel.isHidden = false
        textfield.layer.borderColor = UIColor.red.cgColor
        textfield.layer.borderWidth = 1.0
        textfield.layer.cornerRadius = 5.0
    }
    func textFieldReset(_ textfield: UITextField, _ errorLabel: UILabel){
        textfield.layer.borderColor = UIColor.lightGray.cgColor
        textfield.layer.borderWidth = 0
        textfield.layer.cornerRadius = 5.0
        errorLabel.isHidden = true
    }
}
