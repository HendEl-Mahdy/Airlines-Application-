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
            return "The URL provided is invalid. Please check the URL and try again."
        case .parsingError:
            return "Data parsing error. Please try again."
            
        }
        
    }
}
