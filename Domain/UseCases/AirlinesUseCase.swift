//
//  AirlinesUseCase.swift
//  AirlinesApplication
//
//  Created by HendEl-Mahdy on 21/08/2024.
//

import Foundation
import RxSwift

protocol AirlinesUseCaseProtocol {
    func fetchAirlines() -> Observable<Result<[AirlinesEntity], AppError>>
    func searchAirline(searchName: String) -> Observable<Result<[AirlinesEntity], AppError>>
    func addAirline(airline: InputData) -> Observable<Result<Void, AppError>>
}

class AirlinesUseCase: AirlinesUseCaseProtocol {
    private let repository: AirlineRepositoryProtocol
    
    init(repository: AirlineRepositoryProtocol = AirlineRepository()) {
        self.repository = repository
    }
    
    func fetchAirlines() -> Observable<Result<[AirlinesEntity], AppError>> {
        return repository.fetchAirlines()
    }
    
    func searchAirline(searchName: String) -> Observable<Result<[AirlinesEntity], AppError>> {
        return repository.searchAirlines(for: searchName)
    }
    
    func addAirline(airline: InputData) -> Observable<Result<Void, AppError>> {
        return repository.addAirline(airline)
    }
}
