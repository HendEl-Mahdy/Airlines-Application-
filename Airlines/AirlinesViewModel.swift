//
//  AirlinesViewModel.swift
//  AirlinesApplication
//
//  Created by admin user on 19/07/2024.
//

import Foundation
import CoreData
import UIKit
import RxSwift

protocol AirlinesProtocol {
    
    var dataSource: Observable<[AirlineCellViewModel]>? {get}
    func checkSavingData()
    func numberOfSections() -> Int
    func numberOfRows() -> Int
    func getAirlineData(index: Int) -> AirlinesEntity
    func searchForName(for searchName: String)
    
}

class AirlinesViewModel: AirlinesProtocol {
    
    private var airlinesArray = [AirlinesEntity]()
    private var dataManagment = DataManagement()
    private let airlinesArraySubject = BehaviorSubject<[AirlinesEntity]>(value: [])
    
    var dataSource: Observable<[AirlineCellViewModel]>? {
        return airlinesArraySubject
            .map { airlines in
                self.airlinesArray.compactMap({AirlineCellViewModel(airlineData: $0)})
            }.asObservable()
    }
    
    func numberOfSections() -> Int{
        return Constants.numberOfSections
    }
    
    func numberOfRows() -> Int{
        return airlinesArray.count
    }
    
    func getAirlineData(index: Int) -> AirlinesEntity{
        return airlinesArray[index]
    }
    
    func checkSavingData(){
        
        if airlinesArray.isEmpty {
            APICaller.getAirlinesData { result in
                switch result{
                case .success(let data):
                    self.insertData(data: data)
                case .failure(let error):
                    print(error)
                }
            }
        }
        else {
            loadData()
        }
    }
    
    private func insertData(data: [InputData]){
        for i in 0...100 {
            dataManagment.addToCoreData(airlineData: data[i])
        }
        loadData()
        airlinesArraySubject.onNext(airlinesArray)
    }
    
    
    private func loadData(){
        airlinesArray = []
        let request: NSFetchRequest<AirlinesEntity> = AirlinesEntity.fetchRequest()
        do{
            airlinesArray = try dataManagment.context.fetch(request)
        }catch{
            print(Constants.requestError)
        }
    }
    
    func searchForName(for searchName: String){
        
        let request: NSFetchRequest<AirlinesEntity> = AirlinesEntity.fetchRequest()
        if searchName == Constants.emptyString{
            loadData()
        }else{
            request.predicate = NSPredicate(format: Constants.searchFormat, searchName)
            request.sortDescriptors = [NSSortDescriptor(key: Constants.searchKey, ascending: true)]
            do{
                airlinesArray = try dataManagment.context.fetch(request)
            }catch{
                print(Constants.requestError)
            }
        }
        
    }
}


