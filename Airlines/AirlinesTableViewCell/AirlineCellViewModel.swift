//
//  AirlineCellViewModel.swift
//  AirlinesApplication
//
//  Created by admin user on 19/07/2024.
//
import Foundation


struct AirlineCellViewModel{
    
    private var titleName: String
    
    init(airlineData: AirlinesEntity) {
        self.titleName = airlineData.name!
    }
    
}
