//
//  AirlinesUseCase.swift
//  AirlinesApplication
//
//  Created by HendEl-Mahdy on 21/08/2024.
//

import Foundation
import RxSwift

protocol AirlinesUseCaseProtocol {
    func fetchAirlines() -> Observable<Result<[DataModel], AppError>>
    func searchAirline(searchName: String) -> Observable<Result<[DataModel], AppError>>
    func addAirline(airline: DataModel) -> Observable<Result<Void, AppError>>
}

class AirlinesUseCase: AirlinesUseCaseProtocol {
    private let repository: AirlineRepositoryProtocol
    
    init(repository: AirlineRepositoryProtocol = AirlineRepository()) {
        self.repository = repository
    }
    
    func fetchAirlines() -> Observable<Result<[DataModel], AppError>> {
        return repository.fetchAirlines()
    }
    
    func searchAirline(searchName: String) -> Observable<Result<[DataModel], AppError>> {
        return repository.searchAirlines(for: searchName)
    }
    
    func addAirline(airline: DataModel) -> Observable<Result<Void, AppError>> {
        return repository.addAirline(airline)
    }
}
