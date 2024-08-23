//
//  Constants.swift
//  AirlinesApplication
//
//  Created by HendEl-Mahdy on 25/07/2024.
//

import Foundation

struct Constants{
    
    static let emptyString = ""
    static let space = " "
    static let validURL = ".com"
    static let dataChangedKey = "isDataChanged"
    
    static let cellIdentifier = "airlineCell"
    static let cellVC = "AirlineTableViewCell"
    static let cellBorderWidth: CGFloat = 2
    static let cellCornerRadius: CGFloat = 5
    static let cellHeight: CGFloat = 85
    
    static let numberOfSections = 1
    static let searchKey = "name"
    static let searchFormat = "name CONTAINS[cd] %@"
    
    static let addVC = "AddAirlinesViewController"
    static let airlineTitle = "Airlines"
    
    static let detailsVC = "DetailsViewController"
    static let detailsTitle = "Airline Details"
    
    static let savingError = "Saving Error"
    static let requestError = "Data Request Error"
    static let loadDataError = "Failed to load data"
    static let websitErrorMessage = "Website Not Found"
}
