//
//  Mapper.swift
//  AirlinesApplication
//
//  Created by HendEl-Mahdy on 21/08/2024.
//

import Foundation
import CoreData

class Mapper {
    
    static func mapToAirlineEntity(inputDataArray: [DataModel], context: NSManagedObjectContext){
        for data in inputDataArray {
            mapAirline(airline: data, context: context)
        }
    }
    
    static func mapAirline(airline: DataModel, context: NSManagedObjectContext){
        let newAirline = AirlinesEntity(context: context)
        
        newAirline.name = airline.name
        newAirline.country = airline.country
        newAirline.head_quaters = airline.head_quaters
        newAirline.slogan = airline.slogan
        newAirline.website = airline.website
    }
    
    static func mapToDataModel(airlinesArray: [AirlinesEntity]) -> [DataModel]{
        var inputDataArray = [DataModel]()
        
        for airline in airlinesArray {
            let newAirline = DataModel(name: airline.name ?? Constants.emptyString, country: airline.country, slogan: airline.slogan, head_quaters: airline.head_quaters, website: airline.website)
            inputDataArray.append(newAirline)
        }
        return inputDataArray
    }
}
