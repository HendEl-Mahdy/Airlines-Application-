//
//  Constants.swift
//  AirlinesApplication
//
//  Created by admin user on 25/07/2024.
//

import Foundation

struct Constants{
    
    static let apiURL = "https://api.instantwebtools.net/v1/airlines"
    static let emptyString = ""
    static let validURL = ".com"
    
    static let cellIdentifier = "airlineCell"
    static let cellVC = "AirlineCellViewController"
    static let cellBorderWidth: CGFloat = 2
    static let cellCornerRadius: CGFloat = 5
    static let cellHeight: CGFloat = 85
    
    static let numberOfSections = 1
    static let searchKey = "name"
    
    static let addVC = "AddAirlinesViewController"
    static let airlineTitle = "Airlines"
    
    static let detailsVC = "DetailsViewController"
    static let detailsTitle = "Airline Details"
    
    
    static let savingError = "Saving Error."
    static let requestError = "Data Request Error"
    static let websitErrorMessage = "Website Not Found"
    
}
