//
//  DataManagement.swift
//  AirlinesApplication
//
//  Created by admin user on 11/08/2024.
//

import Foundation
import UIKit

struct DataManagement{
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func addToCoreData(airlineData: InputData){
        
        let newAirline = AirlinesEntity(context: context)
        
        newAirline.name = airlineData.name
        newAirline.country = airlineData.country
        newAirline.head_quaters = airlineData.head_quaters
        newAirline.slogan = airlineData.slogan
        newAirline.website = airlineData.website
        
        saveAirlines()
    }
    
    func saveAirlines(){
        do{
            try context.save()
            
        }catch{
            print(Constants.savingError)
        }
    }
}
