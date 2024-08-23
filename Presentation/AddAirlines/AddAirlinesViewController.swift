//
//  AddAirlinesViewController.swift
//  AirlinesApplication
//
//  Created by HendEl-Mahdy on 23/07/2024.
//

import UIKit
import RxSwift


class AddAirlinesViewController: UIViewController {
    
    private var viewModel: AddAirlinesProtocol = AddAirlinesViewModel()
    private let disposeBag = DisposeBag()
    
    @IBOutlet private(set) weak var container: UIView!
    
    @IBOutlet private(set) weak var nameTextField: UITextField!
    @IBOutlet private(set) weak var sloganTextField: UITextField!
    @IBOutlet private(set) weak var countryTextField: UITextField!
    @IBOutlet private(set) weak var headquatersTextField: UITextField!
    @IBOutlet private(set) weak var websiteTextField: UITextField!
    
    @IBOutlet private(set) weak var errorNameLabel: UILabel!
    @IBOutlet private(set) weak var errorWebsiteLabel: UILabel!
    @IBOutlet private(set) weak var cancelButton: UIButton!
    @IBOutlet private(set) weak var confirmButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        keyboardNotification()
        bindToDismissViewController()
        setupDelegate()
    }
    
    
    private func addAirline(){
        viewModel.insertAirline(name: nameTextField.text ?? Constants.emptyString,
                                country: countryTextField.text,
                                slogan: sloganTextField.text,
                                headquaters: headquatersTextField.text,
                                website: websiteTextField.text ?? Constants.emptyString)
    }
    
    private func bindToDismissViewController(){
        viewModel.dismissViewControllerTrigger?
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.dismiss(animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }
    
    @IBAction private func confirmButtonPressed(_ sender: Any) {
        validateInputData(nameTextField, websiteTextField, errorNameLabel, errorWebsiteLabel)
    }
    
    @IBAction private func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setup(){
        container.round(radius: 15)
        container.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        cancelButton.addBorder(color: .gray, width: 0.3)
        cancelButton.addCornerRadius(cornerRadius: 0.02)
        confirmButton.addCornerRadius(cornerRadius: 0.02)
        
        errorNameLabel.isHidden =  true
        errorWebsiteLabel.isHidden = true
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

extension AddAirlinesViewController: UITextFieldDelegate{
    
    //  MARK: - TextField Validation
    
    private func validateInputData(_ name: UITextField, _ website: UITextField,
                                   _ nameLabel: UILabel, _ websiteLabel: UILabel ){
        
        if name.text == Constants.emptyString && !website.text!.contains(Constants.validURL){
            textFieldReset(name, nameLabel)
            textFieldReset(website, websiteLabel)
            validationError(name, nameLabel)
            validationError(website, websiteLabel)
        }
        else if name.text != Constants.emptyString && !website.text!.contains(Constants.validURL){
            textFieldReset(name, nameLabel)
            textFieldReset(website, websiteLabel)
            validationError(website, websiteLabel)
        }
        else if name.text == Constants.emptyString && website.text!.contains(Constants.validURL){
            textFieldReset(name, nameLabel)
            textFieldReset(website, websiteLabel)
            validationError(name, nameLabel)
        }
        else{
            textFieldReset(name, nameLabel)
            textFieldReset(website, websiteLabel)
            addAirline()
            
        }
    }
    
    private func validationError(_ textfield: UITextField, _ errorLabel: UILabel){
        errorLabel.isHidden = false
        textfield.layer.borderColor = UIColor.red.cgColor
        textfield.layer.borderWidth = 1.0
        textfield.layer.cornerRadius = 5.0
    }
    private func textFieldReset(_ textfield: UITextField, _ errorLabel: UILabel){
        textfield.layer.borderColor = UIColor.lightGray.cgColor
        textfield.layer.borderWidth = 0
        textfield.layer.cornerRadius = 5.0
        errorLabel.isHidden = true
    }
    
    // MARK: - Keyboard Handling
    
    private func setupDelegate(){
        nameTextField.delegate = self
        sloganTextField.delegate = self
        countryTextField.delegate = self
        headquatersTextField.delegate = self
        websiteTextField.delegate = self
        
        nameTextField.returnKeyType = .next
        sloganTextField.returnKeyType = .next
        countryTextField.returnKeyType = .next
        headquatersTextField.returnKeyType = .next
        websiteTextField.returnKeyType = .go
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameTextField:
            sloganTextField.becomeFirstResponder()
        case sloganTextField:
            countryTextField.becomeFirstResponder()
        case countryTextField:
            headquatersTextField.becomeFirstResponder()
        case headquatersTextField:
            websiteTextField.becomeFirstResponder()
        case websiteTextField:
            validateInputData(nameTextField, websiteTextField, errorNameLabel, errorWebsiteLabel)
            textField.resignFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}
