//
//  AppError.swift
//  AirlinesApplication
//
//  Created by HendEl-Mahdy on 18/07/2024.
//

import Foundation

enum AppError: Error{
    case loadDataError
    case saveDataError
    
    var networkError: String{
        switch self{
        case .loadDataError:
            return Constants.loadDataError
        case .saveDataError:
            return Constants.savingError
        }
    }
}
