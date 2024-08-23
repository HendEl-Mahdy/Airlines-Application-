//
//  AirlineRepository.swift
//  AirlinesApplication
//
//  Created by HendEl-Mahdy on 21/08/2024.
//

import Foundation
import RxSwift

class AirlineRepository : AirlineRepositoryProtocol {
    
    private let dataSource: DataSourceProtocol
    
    init(localDataSource: DataSourceProtocol = DataSource()) {
        self.dataSource = localDataSource
    }
    
    func fetchAirlines() -> RxSwift.Observable<Result<[AirlinesEntity], AppError>> {
        return dataSource.getAirlines()
    }
    
    func searchAirlines(for searchName: String) -> RxSwift.Observable<Result<[AirlinesEntity], AppError>> {
        return dataSource.searchAirlines(for: searchName)
    }
    
    func addAirline(_ airline: InputData) -> RxSwift.Observable<Result<Void, AppError>> {
        return dataSource.addAirline(airline)
    }
}
