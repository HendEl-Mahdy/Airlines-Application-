//
//  AppError.swift
//  AirlinesApplication
//
//  Created by admin user on 18/07/2024.
//

import Foundation

enum AppError: Error{
    case invalidURLError
    case parsingError
    
    var networkError: String{
        switch self{
        case .invalidURLError:
            return Constants.invalidURLError
        case .parsingError:
            return Constants.parsingError
            
        }
    }
}
