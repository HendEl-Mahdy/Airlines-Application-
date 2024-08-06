//
//  AirlineCellViewModel.swift
//  AirlinesApplication
//
//  Created by admin user on 19/07/2024.
//
import Foundation
import UIKit
import CoreData

class AirlineCellViewModel{
    
    var titleName: String
    var image: UIImageView!
    
    init(airlineData: AirlinesEntity) {
        self.titleName = airlineData.name!
    }
    
}
