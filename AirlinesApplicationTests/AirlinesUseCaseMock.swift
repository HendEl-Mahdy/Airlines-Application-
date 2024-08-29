//
//  AirlinesUseCaseMock.swift
//  AirlinesApplicationTests
//
//  Created by HendEl-Mahdy on 25/08/2024.
//

import Foundation
import RxSwift
@testable  import AirlinesApplication

class AirlinesUseCaseMock: AirlinesUseCaseProtocol {
    
    var isSuccessfull: Bool
    
    init(isSuccessfull: Bool = true) {
        self.isSuccessfull =  isSuccessfull
    }
    
    func fetchAirlines() -> Observable<Result<[DataModel], AppError>> {
        if isSuccessfull{
            return .just(.success(getMockedData()))
        }else{
            return .just(.failure(.loadDataError))
        }
        
    }
    
    func searchAirline(searchName: String) -> Observable<Result<[DataModel], AppError>> {
        if isSuccessfull{
            var result = [DataModel]()
            for data in mockData{
                if data.name.contains(searchName){
                    result.append(data)
                }
            }
            return .just(.success(result))
        }else{
            return .just(.failure(.loadDataError))
        }
    }
    
    func addAirline(airline: DataModel) -> Observable<Result<Void, AppError>> {
        if isSuccessfull{
            mockData.append(airline)
            return .of(.success(()))
        }else{
            return .of(.failure(.saveDataError))
        }
    }
    
    private func getMockedData() -> [DataModel]{
        return mockData
    }
}
