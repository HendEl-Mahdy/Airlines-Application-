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
        
        viewModel.dismissViewControllerTrigger
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] result in
                switch result{
                case .success(_):
                    self?.dismiss(animated: true, completion: nil)
                    self?.textFieldReset(self?.nameTextField, self?.errorNameLabel)
                    self?.textFieldReset(self?.websiteTextField, self?.errorWebsiteLabel)
                case .failure(let error):
                    self?.showToastAlert(controller: self, message: "\(error.networkError)", Seconds: Double(Constants.addAirlineToastWait))
                }
            }).disposed(by: disposeBag)
    }
    
    private func bindToValidateTextField(){
        
        textFieldReset(nameTextField, errorNameLabel)
        textFieldReset(websiteTextField, errorWebsiteLabel)
        
        viewModel.nameObservable
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self]  in
                if let nameTextField = self?.nameTextField, let errorNameLabel = self?.errorNameLabel{
                    
                    self?.validationError(nameTextField, errorNameLabel)
                }
            }).disposed(by: disposeBag)
        
        viewModel.websiteObservable
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self]  in
                
                if let websiteTextField = self?.websiteTextField, let errorWebsiteLabel = self?.errorWebsiteLabel {
                    
                    self?.validationError(websiteTextField, errorWebsiteLabel)
                }
            }).disposed(by: disposeBag)
        
    }
    
    @IBAction private func confirmButtonPressed(_ sender: Any) {
        bindToValidateTextField()
        addAirline()
    }
    
    @IBAction private func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setup(){
        container.round(radius: CGFloat(Constants.addAirline_container_radius))
        container.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        cancelButton.addBorder(color: .gray, width: Constants.addAirline_cancelButton_width)
        cancelButton.addCornerRadius(cornerRadius: Constants.addAirline_cancelButton_cornerRadius)
        confirmButton.addCornerRadius(cornerRadius: Constants.addAirline_confirmButton_cornerRadius)
        
        errorNameLabel.isHidden =  true
        errorWebsiteLabel.isHidden = true
        
    }
    private func showToastAlert(controller: UIViewController?, message: String, Seconds: Double){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = UIColor.clear
        alert.view.layer.cornerRadius = CGFloat(Constants.toastCornerRadius)
        controller?.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Seconds){
            alert.dismiss(animated: true)
        }
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
}

extension AddAirlinesViewController: UITextFieldDelegate{
    
    //  MARK: - TextField Validation
    
    private func validationError(_ textfield: UITextField?, _ errorLabel: UILabel?){
        errorLabel?.isHidden = false
        textfield?.layer.borderColor = UIColor.red.cgColor
        textfield?.layer.borderWidth = Constants.addAirline_textField_validationError_borderWidth
        textfield?.layer.cornerRadius = Constants.addAirline_textField_validationError_cornerRadius
    }
    private func textFieldReset(_ textfield: UITextField?, _ errorLabel: UILabel?){
        textfield?.layer.borderColor = UIColor.lightGray.cgColor
        textfield?.layer.borderWidth = CGFloat(Constants.addAirline_textField_textFieldReset_borderWidth)
        textfield?.layer.cornerRadius = Constants.addAirline_textField_textFieldReset_cornerRadius
        errorLabel?.isHidden = true
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
            addAirline()
            textField.resignFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}
