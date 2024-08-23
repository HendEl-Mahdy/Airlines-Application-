//
//  AirlineRepositoryProtocol.swift
//  AirlinesApplication
//
//  Created by HendEl-Mahdy on 21/08/2024.
//

import Foundation
import RxSwift

protocol AirlineRepositoryProtocol {
    func fetchAirlines() -> Observable<Result<[AirlinesEntity], AppError>>
    func searchAirlines(for searchName: String) -> Observable<Result<[AirlinesEntity], AppError>>
    func addAirline(_ airline: InputData) -> Observable<Result<Void, AppError>>
}
