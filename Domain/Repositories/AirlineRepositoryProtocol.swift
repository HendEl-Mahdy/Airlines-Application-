//
//  AirlineRepositoryProtocol.swift
//  AirlinesApplication
//
//  Created by HendEl-Mahdy on 21/08/2024.
//

import Foundation
import RxSwift

protocol AirlineRepositoryProtocol {
    func fetchAirlines() -> Observable<Result<[DataModel], AppError>>
    func searchAirlines(for searchName: String) -> Observable<Result<[DataModel], AppError>>
    func addAirline(_ airline: DataModel) -> Observable<Result<Void, AppError>>
}
