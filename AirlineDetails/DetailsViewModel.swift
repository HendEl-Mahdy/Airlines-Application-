//
//  DetailsViewModel.swift
//  AirlinesApplication
//
//  Created by admin user on 20/07/2024.
//

import Foundation
import UIKit

class DetailsViewModel{
    var airline: AirlinesEntity
    
    var name:String
    var country: String?
    var slogan: String?
    var headquaters:String?
    var website: String?
    
    init(airline: AirlinesEntity) {
        self.airline = airline
        self.name = airline.name!
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
    
}

