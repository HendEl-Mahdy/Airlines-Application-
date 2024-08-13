//
//  AddAirlinesViewController.swift
//  AirlinesApplication
//
//  Created by admin user on 23/07/2024.
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
        bindKeyboardHeight()
    }
    
    private func addAirline(){
        viewModel.insertAirline(name: nameTextField,
                                country: countryTextField.text,
                                slogan: sloganTextField.text,
                                headquaters: headquatersTextField.text,
                                website: websiteTextField,
                                nameLabel: errorNameLabel,
                                websiteLabel: errorWebsiteLabel)
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
        addAirline()
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
    
    //  MARK: - Keyboard Settings
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func bindKeyboardHeight(){
        viewModel.keyboardHeight
            .subscribe(onNext: { [weak self] keyboardHeight in
                self?.adjustContentForKeyboard(show: true, keyboardHeight: keyboardHeight)
            })
            .disposed(by: disposeBag)
    }
    
    private func keyboardNotification(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        adjustContentForKeyboard(show: false, keyboardHeight: 0)
    }
    
    private func adjustContentForKeyboard(show: Bool, keyboardHeight: CGFloat) {
        let adjustmentHeight = show ? keyboardHeight : 0
        view.frame.origin.y = -adjustmentHeight
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
