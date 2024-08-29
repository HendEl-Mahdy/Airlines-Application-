//
//  AddAirlinesViewModel.swift
//  AirlinesApplication
//
//  Created by HendEl-Mahdy on 20/07/2024.
//
import Foundation
import RxSwift


protocol AddAirlinesProtocol{
    var nameObservable: PublishSubject<Void> { get }
    var websiteObservable: PublishSubject<Void> { get }
    var dismissViewControllerTrigger: PublishSubject<Result<Void, AppError>>? {get}
    
    func insertAirline(name: String, country: String?, slogan: String?, headquaters: String?, website: String)
}

class AddAirlinesViewModel: AddAirlinesProtocol{
    var nameObservable: PublishSubject<Void> = PublishSubject()
    var websiteObservable: PublishSubject<Void> = PublishSubject()
    
    var dismissViewControllerTrigger: PublishSubject<Result<Void, AppError>>? =  PublishSubject<Result<Void, AppError>>()
    
    private let useCase: AirlinesUseCaseProtocol
    private let disposeBag = DisposeBag()
    
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
                    self?.dismissViewControllerTrigger?.onNext(.success(()))
                case .failure(let error):
                    self?.dismissViewControllerTrigger?.onNext(.failure(error))
                }
                
            }).disposed(by: disposeBag)
    }
    
    private func validateInput(airline: DataModel){
        if airline.name == Constants.emptyString && !(airline.website?.contains(Constants.validURL) ?? true){
            
            nameObservable.onNext(())
            websiteObservable.onNext(())
        }
        else if airline.name != Constants.emptyString && !(airline.website?.contains(Constants.validURL) ?? false){
            
            websiteObservable.onNext(())
        }
        else if airline.name == Constants.emptyString && ((airline.website?.contains(Constants.validURL)) != nil){
            
            nameObservable.onNext(())
        }
        else{
            addAirlineData(airline: airline)
            
        }
    }
}
