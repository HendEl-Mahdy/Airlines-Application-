//
//  AirlinesViewModel.swift
//  AirlinesApplication
//
//  Created by HendEl-Mahdy on 19/07/2024.
//

import Foundation
import RxSwift

protocol AirlinesProtocol {
    
    var airlinesObservable: Observable<Result<Void, AppError>> { get }
    
    func getNumberOfSections() -> Int
    func getNumberOfRows() -> Int
    func getAirlineData(index: Int) -> DataModel
    func getAirlines()
    func searchForName(for searchName: String)
    
}

class AirlinesViewModel: AirlinesProtocol {
    
    private var airlinesArraySubject = BehaviorSubject<Result<Void, AppError>>(value:       .failure(AppError.loadDataError))
    private let airlinesUseCase : AirlinesUseCaseProtocol
    private let disposeBag = DisposeBag()
    private var airlinesArray = [DataModel]()
    
    var airlinesObservable: Observable<Result<Void, AppError>> {
        return airlinesArraySubject.map { result in
            switch result {
            case .success(_):
                return .success(())
            case .failure(let error):
                return .failure(error)
            }
        }
    }
    
    init(airlinesUseCase: AirlinesUseCaseProtocol = AirlinesUseCase()){
        self.airlinesUseCase = airlinesUseCase
    }
    
    func getNumberOfSections() -> Int{
        return Constants.numberOfSections
    }
    
    func getNumberOfRows() -> Int{
        return airlinesArray.count
    }
    
    func getAirlineData(index: Int) -> DataModel{
        return airlinesArray[index]
    }
    
    func getAirlines() {
        airlinesUseCase.fetchAirlines()
            .subscribe(onNext: { [weak self] result in
                switch result {
                case .success(let airlines):
                    self?.airlinesArray = airlines
                    self?.airlinesArraySubject.onNext(.success(()))
                case .failure(_):
                    self?.airlinesArraySubject.onNext(.failure(.loadDataError))
                }
            })
            .disposed(by: disposeBag)
    }
    
    func searchForName(for searchName: String){
        
        if searchName == Constants.emptyString{
            getAirlines()
        }else{
            let hasLastSpace = searchName.hasSuffix(Constants.space)
            if !hasLastSpace {
                let airlineName = searchName.replacingOccurrences(of: Constants.space, with: Constants.emptyString)
                if airlineName.count >= Constants.numberOfSearchCharacter{
                    airlinesUseCase.searchAirline(searchName: airlineName)
                        .subscribe(onNext: { [weak self] result in
                            switch result {
                            case .success(let airlines):
                                self?.airlinesArray = airlines
                                self?.airlinesArraySubject.onNext(.success(()))
                            case .failure(let error):
                                self?.airlinesArraySubject.onNext(.failure(error))
                            }
                        })
                        .disposed(by: disposeBag)
                }
            }
        }
    }
}
