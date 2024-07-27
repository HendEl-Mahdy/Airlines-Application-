//
//  AddAirlinesViewController.swift
//  AirlinesApplication
//
//  Created by admin user on 23/07/2024.
//

import UIKit

class AddAirlinesViewController: UIViewController {
    
    var viewModel = AddAirlinesViewModel()
    var validateInput = TextFieldValidation()
    
    @IBOutlet weak var container: UIView!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var sloganTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var headquatersTextField: UITextField!
    @IBOutlet weak var websiteTextField: UITextField!

    @IBOutlet weak var errorNameLabel: UILabel!
    @IBOutlet weak var errorWebsiteLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        keyboardNotification()
    }
    
    
    @IBAction func confirmButtonPressed(_ sender: Any) {
        let validationNumber = validateInput.validateInputData(nameTextField, websiteTextField, errorNameLabel, errorWebsiteLabel)
        if  validationNumber == 3{
            addAirline()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func addAirline(){
        
        viewModel.insertAirline(name: nameTextField.text!,
                               country: countryTextField.text,
                               slogan: sloganTextField.text,
                               headquaters: headquatersTextField.text,
                               website: websiteTextField.text!)
    }
    
    func setup(){
        container.round(radius: 15)
        container.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        cancelButton.addBorder(color: .gray, width: 0.3)
        cancelButton.addCornerRadius(cornerRadius: 0.02)
        confirmButton.addCornerRadius(cornerRadius: 0.02)
        
        errorNameLabel.isHidden =  true
        errorWebsiteLabel.isHidden = true
        
    }
    
    //  MARK: - Keyboard Settings
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
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

//  MARK: - AddAirlines protocol

protocol AddAirlinesViewDelegate{
    
    func dataReload()
    
}


