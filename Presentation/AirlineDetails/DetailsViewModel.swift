//
//  DetailsViewModel.swift
//  AirlinesApplication
//
//  Created by HendEl-Mahdy on 20/07/2024.
//

import Foundation
import RxSwift

protocol DetailsProtocol{
    var websiteURLSubject: PublishSubject<URLRequest>? {get}
    var emptyURLSubject: PublishSubject<Void>? {get}
    var name: String {get}
    var country: String? {get}
    var slogan: String? {get}
    var headquaters: String? {get}
    var website: String? {get}
    func validateText() -> Bool
    func handleUrl()
}

struct DetailsViewModel: DetailsProtocol{
    
    var emptyURLSubject: RxSwift.PublishSubject<Void>? = PublishSubject<Void>()
    var websiteURLSubject: RxSwift.PublishSubject<URLRequest>? = PublishSubject<URLRequest>()
    var name: String
    var country: String?
    var slogan: String?
    var headquaters: String?
    var website: String?
    
    private var airline: AirlinesEntity
    
    init(airline: AirlinesEntity) {
        self.airline = airline
        self.name = airline.name ?? Constants.emptyString
        self.country = airline.country
        self.slogan = airline.slogan
        self.headquaters = airline.head_quaters
        
        if let websiteLink = airline.website {
            if !websiteLink.contains(Constants.validURL) {
                self.website = Constants.emptyString
            } else {
                self.website = websiteLink
            }
        } else {
            self.website = Constants.emptyString
        }
    }
    
    func validateText() -> Bool{
        if let headquaters = headquaters {
            if headquaters == Constants.emptyString{
                return true
            }else{
                return false
            }
        }else{
            return true
        }
    }
    
    func handleUrl(){
        guard let websiteUrl = website else {return}
        if urlIsEmpty(url: websiteUrl ){
            self.emptyURLSubject?.onNext(())
        }else{
            self.websiteURLSubject?.onNext(convertStringToURLRequest(url: websiteUrl))
        }
    }
    
    private func urlIsEmpty(url: String) ->  Bool{
        return url == Constants.emptyString
    }
    
    private func convertStringToURLRequest(url: String) -> URLRequest{
        let url = URL(string: url)!
        let urlRequest = URLRequest(url: url)
        return urlRequest
    }
    
}

