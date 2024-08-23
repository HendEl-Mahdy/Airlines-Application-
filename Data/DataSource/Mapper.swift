//
//  Mapper.swift
//  AirlinesApplication
//
//  Created by HendEl-Mahdy on 21/08/2024.
//

import Foundation
import CoreData

class Mapper {
    
    static func mapInputData(inputDataArray: [InputData], context: NSManagedObjectContext){
        for data in inputDataArray {
            mapAirline(airline: data, context: context)
        }
    }
    
    static func mapAirline(airline: InputData, context: NSManagedObjectContext){
        let newAirline = AirlinesEntity(context: context)
        
        newAirline.name = airline.name
        newAirline.country = airline.country
        newAirline.head_quaters = airline.head_quaters
        newAirline.slogan = airline.slogan
        newAirline.website = airline.website
    }
}
