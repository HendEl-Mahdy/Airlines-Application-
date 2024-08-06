//
//  AddAirlinesViewModel.swift
//  AirlinesApplication
//
//  Created by admin user on 20/07/2024.
//
import Foundation
import CoreData
import UIKit

class AddAirlinesViewModel{

    var delegate : AddAirlinesViewDelegate?
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    func insertAirline(name:String,
                       country:String?,
                       slogan:String?,
                       headquaters:String?,
                       website:String) {
        
        let airlineData = AirlinesEntity(context: context)
        airlineData.name = name
        airlineData.country = country
        airlineData.slogan = slogan
        airlineData.head_quaters = headquaters
        airlineData.website = website
        
        saveAirlines()
    }
    
    private func saveAirlines(){
        do{
            try context.save()
            delegate?.dataReload()
        }catch{
            print(Constants.savingError)
        }
    }
    
}
