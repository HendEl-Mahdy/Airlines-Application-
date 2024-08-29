//
//  DataSource.swift
//  AirlinesApplication
//
//  Created by HendEl-Mahdy on 21/08/2024.
//

import Foundation
import UIKit
import CoreData
import RxSwift

protocol DataSourceProtocol {
    func getAirlines() -> Observable<Result<[DataModel], AppError>>
    func searchAirlines(for searchName: String) -> Observable<Result<[DataModel], AppError>>
    func addAirline(_ airline: DataModel) -> Observable<Result<Void, AppError>>
}

class DataSource: DataSourceProtocol {
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private var isDataChanged: Bool {
        get {
            if UserDefaults.standard.object(forKey: Constants.dataChangedKey) == nil {
                return true
            }
            return UserDefaults.standard.bool(forKey: Constants.dataChangedKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Constants.dataChangedKey)
        }
    }
    
    func getAirlines() -> Observable<Result<[DataModel], AppError>> {
        if isDataChanged{
            getMockedData()
            isDataChanged = false
        }
        return getLocalData()
    }
    
    private func getLocalData() -> Observable<Result<[DataModel], AppError>> {
        let request: NSFetchRequest<AirlinesEntity> = AirlinesEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: Constants.searchKey, ascending: true)]
        
        do {
            let airlines = try context.fetch(request)
            let newAirlines = Mapper.mapToDataModel(airlinesArray: airlines)
            return .just(.success(newAirlines))
        } catch {
            return .just(.failure(.loadDataError))
        }
    }
    
    private func getMockedData(){
        Mapper.mapToAirlineEntity(inputDataArray: mockData, context: context)
        saveAirlines()
    }
    
    func searchAirlines(for searchName: String) -> Observable<Result<[DataModel], AppError>> {
        let request: NSFetchRequest<AirlinesEntity> = AirlinesEntity.fetchRequest()
        request.predicate = NSPredicate(format: Constants.searchFormat, searchName)
        request.sortDescriptors = [NSSortDescriptor(key: Constants.searchKey, ascending: true)]
        
        do {
            let airlines = try context.fetch(request)
            let newAirlines = Mapper.mapToDataModel(airlinesArray: airlines)
            return .just(.success(newAirlines))
        } catch {
            return .just(.failure(.loadDataError))
        }
    }
    
    func addAirline(_ airline: DataModel) -> Observable<Result<Void, AppError>>{
        Mapper.mapAirline(airline: airline, context: context)
        return saveAirline()
    }
    
    private func saveAirline() -> Observable<Result<Void, AppError>> {
        do {
            try context.save()
            return .just(.success(()))
        } catch{
            return .just(.failure(.saveDataError))
        }
    }
    
    private func saveAirlines(){
        do{
            try context.save()
        }catch{
            print(AppError.saveDataError)
        }
    }
}
