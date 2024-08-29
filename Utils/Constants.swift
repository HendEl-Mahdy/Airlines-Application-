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
    static let keyboardHeight = 0
    
    static let cellIdentifier = "airlineCell"
    static let cellVC = "AirlineTableViewCell"
    static let cellBorderWidth: CGFloat = 2
    static let cellCornerRadius: CGFloat = 5
    static let cellHeight: CGFloat = 85
    
    static let numberOfSections = 1
    static let searchKey = "name"
    static let searchFormat = "name CONTAINS[cd] %@"
    static let numberOfSearchCharacter = 3
    
    static let addVC = "AddAirlinesViewController"
    static let addAirlineToastWait = 1
    static let addAirline_container_radius  = 15
    static let addAirline_cancelButton_width = 0.3
    static let addAirline_cancelButton_cornerRadius  = 0.02
    static let addAirline_confirmButton_cornerRadius  = 0.02
    static let addAirline_textField_validationError_borderWidth = 1.0
    static let addAirline_textField_validationError_cornerRadius = 5.0
    static let addAirline_textField_textFieldReset_borderWidth = 0
    static let addAirline_textField_textFieldReset_cornerRadius = 5.0
    
    
    static let airlineTitle = "Airlines"
    static let searchButton_cornerRaduis = 0.2
    static let airlineToastWait = 1
    static let toastCornerRadius = 15
    static let airlineNavigationOpacity = 0.2
    static let airlineButtonOpacity = 0.2
    static let addButton_frame_x = 160
    static let addButton_frame_y = 100
    static let addButton_frame_width = 62
    static let addButton_frame_height = 62
    static let addButton_cornerRadius = 0.5
    static let addButton_shadowRadius = 5.0
    static let addButton_shadowOpacity = 0.2
    
    
    static let detailsVC = "DetailsViewController"
    static let detailsTitle = "Airline Details"
    static let detailsToastWait = 0.6
    static let details_navigationView_shadowOpacity = 0.2
    static let details_detailedView_cornerRadius = 0.02
    static let details_detailedView_shadowOpacity = 0.3
    static let details_visitButton_cornerRadius = 0.02
    
    static let UIViewExtensions_navigationShadow_Opacity = 0.5
    static let UIViewExtensions_navigationShadow_widthOffset = 0
    static let UIViewExtensions_navigationShadow_heightOffset = 2
    static let UIViewExtensions_navigationShadow_radius = 2
    static let UIViewExtensions_detailedShadow_Opacity = 0.5
    static let UIViewExtensions_detailedShadow_offset: CGSize = .zero
    static let UIViewExtensions_detailedShadow_radius = 2
    
    static let savingError = "Saving Error"
    static let requestError = "Data Request Error"
    static let loadDataError = "Failed to load data"
    static let websitErrorMessage = "Website Not Found"
    static let fatalError  = "init(coder:) has not been implemented"
}
