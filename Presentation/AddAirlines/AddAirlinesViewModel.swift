//
//  AddAirlinesViewModel.swift
//  AirlinesApplication
//
//  Created by HendEl-Mahdy on 20/07/2024.
//
import Foundation
import RxSwift


protocol AddAirlinesProtocol{
    var nameObservable: Observable<Void> { get }
    var websiteObservable: Observable<Void> { get }
    var dismissViewControllerTrigger: Observable<Result<Void, AppError>> {get}
    
    func insertAirline(name: String, country: String?, slogan: String?, headquaters: String?, website: String)
}

class AddAirlinesViewModel: AddAirlinesProtocol{
    private var nameSubject: PublishSubject<Void> = PublishSubject()
    private var websiteSubject: PublishSubject<Void> = PublishSubject()
    private var dismissViewControllerSubject: PublishSubject<Result<Void, AppError>> =  PublishSubject<Result<Void, AppError>>()
    private let useCase: AirlinesUseCaseProtocol
    private let disposeBag = DisposeBag()
    
    var nameObservable: Observable<Void> {
        return nameSubject.map { result in
            return()
        }
    }
    
    var websiteObservable: Observable<Void> {
        return websiteSubject.map { result in
            return()
        }
    }
    
    var dismissViewControllerTrigger: Observable<Result<Void, AppError>> {
        return dismissViewControllerSubject.map { result in
            switch result {
            case .success(_):
                return .success(())
            case .failure(let error):
                return .failure(error)
            }
        }
    }
    
    
    init(useCase: AirlinesUseCaseProtocol = AirlinesUseCase()) {
        self.useCase = useCase
    }
    
    func insertAirline(name: String, country: String?, slogan: String?, headquaters: String?, website: String){
        
        let airlineData = DataModel(name: name, country: country, slogan: slogan, head_quaters: headquaters, website: website)
        
        validateInput(airline: airlineData)
        
    }
    
    private func addAirlineData(airline: DataModel){
        useCase.addAirline(airline: airline)
            .subscribe(onNext: { [weak self] result in
                switch result {
                case .success(()):
                    self?.dismissViewControllerSubject.onNext(.success(()))
                case .failure(let error):
                    self?.dismissViewControllerSubject.onNext(.failure(error))
                }
                
            }).disposed(by: disposeBag)
    }
    
    private func validateInput(airline: DataModel){
        if airline.name == Constants.emptyString && !(airline.website?.contains(Constants.validURL) ?? true){
            
            nameSubject.onNext(())
            websiteSubject.onNext(())
        }
        else if airline.name != Constants.emptyString && !(airline.website?.contains(Constants.validURL) ?? false){
            
            websiteSubject.onNext(())
        }
        else if airline.name == Constants.emptyString && ((airline.website?.contains(Constants.validURL)) != nil){
            
            nameSubject.onNext(())
        }
        else{
            addAirlineData(airline: airline)
            
        }
    }
}
