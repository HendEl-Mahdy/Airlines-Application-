//
//  AirlinesViewModel.swift
//  AirlinesApplication
//
//  Created by admin user on 19/07/2024.
//

import Foundation
import CoreData
import UIKit

class AirlinesViewModel{

    private var airlinesArray = [AirlinesEntity]()
    
    var cellDataSource: Observable<[AirlineCellViewModel]> = Observable(nil)
   
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func mapCellData(){
        self.cellDataSource.value = self.airlinesArray.compactMap({AirlineCellViewModel(airlineData: $0)})
    }
    
    func numberOfSections()->Int{
        return Constants.numberOfSections
    }
    
    func numberOfRows()->Int{
        return airlinesArray.count
    }
    
    func getAirlineData(index: Int)->AirlinesEntity{
        return airlinesArray[index]
    }
    
    func checkSavingData(){
        loadData()
        
        if airlinesArray.isEmpty{
            APICaller.getAirlinesData { result in
                switch result{
                case .success(let data):
                    self.insertData(data: data)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func insertData(data: [InputData]){
        for i in 0...100 {
            addToCoreData(airlineData: data[i])
        }
        loadData()
        mapCellData()
    }
    
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
    
    func loadData(){
        airlinesArray = []
        let request: NSFetchRequest<AirlinesEntity> = AirlinesEntity.fetchRequest()
        do{
            airlinesArray = try context.fetch(request)
        }catch{
            print(Constants.requestError)
        }
    }
    
    func searchForName(for searchName: String){
        
        let request: NSFetchRequest<AirlinesEntity> = AirlinesEntity.fetchRequest()
        if searchName == Constants.emptyString{
            loadData()
        }else{
            request.predicate = NSPredicate(format: "name CONTAINS[cd] %@",searchName)
            request.sortDescriptors = [NSSortDescriptor(key: Constants.searchKey, ascending: true)]
            do{
                airlinesArray = try context.fetch(request)
            }catch{
                print(Constants.requestError)
            }
        }
        
    }
}


