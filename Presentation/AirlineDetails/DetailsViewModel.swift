//
//  DetailsViewModel.swift
//  AirlinesApplication
//
//  Created by HendEl-Mahdy on 20/07/2024.
//

import Foundation
import RxSwift
import RxCocoa

protocol DetailsProtocol{
    var websiteURLDriver: Driver<URLRequest>? { get }
    var emptyURLDriver: Driver<Void>? { get }
    
    var name: String {get}
    var country: String? {get}
    var slogan: String? {get}
    var headquaters: String? {get}
    var website: String? {get}
    
    func validateText() -> Bool
    func handleUrl()
}

struct DetailsViewModel: DetailsProtocol{
    private var emptyURLSubject: RxSwift.PublishSubject<Void>? = PublishSubject<Void>()
    private var websiteURLSubject: RxSwift.PublishSubject<URLRequest>? = PublishSubject<URLRequest>()
    
    var websiteURLDriver: Driver<URLRequest>? {
        return websiteURLSubject?.asDriver(onErrorJustReturn: URLRequest(url: URL(string: Constants.space)!))
    }
    
    var emptyURLDriver: Driver<Void>? {
        return emptyURLSubject?.asDriver(onErrorJustReturn: ())
    }
    
    var name: String
    var country: String?
    var slogan: String?
    var headquaters: String?
    var website: String?
    
    init(airline: DataModel) {
        self.name = airline.name
        self.country = airline.country
        self.slogan = airline.slogan
        self.headquaters = airline.head_quaters
        
        websiteHandling(website: airline.website ?? Constants.emptyString)
        
    }
    
    private mutating func websiteHandling(website: String){
            if !website.contains(Constants.validURL) {
                self.website = Constants.emptyString
            } else {
                self.website = website
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

