//
//  AddAirlinesViewModel.swift
//  AirlinesApplication
//
//  Created by admin user on 20/07/2024.
//
import Foundation
import CoreData
import UIKit
import RxSwift
import RxRelay
import RxCocoa

protocol AddAirlinesProtocol{
    var keyboardHeight: BehaviorRelay<CGFloat> {get}
    var dismissViewControllerTrigger: PublishSubject<Void>? {get}
    
    func insertAirline(name: UITextField, country: String?, slogan: String?, headquaters: String?, website: UITextField, nameLabel: UILabel, websiteLabel: UILabel)
}

class AddAirlinesViewModel: AddAirlinesProtocol{
    
    var keyboardHeight = BehaviorRelay<CGFloat>(value: 0)
    var dismissViewControllerTrigger: RxSwift.PublishSubject<Void>? = PublishSubject<Void>()
    var dataManagment = DataManagement()
    private let disposeBag = DisposeBag()
    private var validateInput = TextFieldValidation()
    
    init() {
        NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification)
            .subscribe(onNext: { [weak self] notification in
                self?.handleKeyboardWillShow(notification: notification)
            })
            .disposed(by: disposeBag)
    }
    
    func insertAirline(name: UITextField,
                       country: String?,
                       slogan: String?,
                       headquaters: String?,
                       website: UITextField,
                       nameLabel: UILabel,
                       websiteLabel: UILabel) {
        
        let validationNumber = validateInput.validateInputData(name, website, nameLabel, websiteLabel)
        
        if  validationNumber == 3 {
            let airlineData = AirlinesEntity(context: dataManagment.context)
            
            airlineData.name = name.text
            airlineData.country = country
            airlineData.slogan = slogan
            airlineData.head_quaters = headquaters
            airlineData.website = website.text
            
            dataManagment.saveAirlines()
            dismissViewControllerTrigger?.onNext(())
        }
    }
    
    private func handleKeyboardWillShow(notification: Notification) {
        if let userInfo = notification.userInfo,
           let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let height = keyboardFrame.height
            keyboardHeight.accept(height)
        }
    }
}
