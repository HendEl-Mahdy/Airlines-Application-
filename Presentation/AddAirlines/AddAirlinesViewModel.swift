//
//  AddAirlinesViewModel.swift
//  AirlinesApplication
//
//  Created by HendEl-Mahdy on 20/07/2024.
//
import Foundation
import RxSwift


protocol AddAirlinesProtocol{
    var dismissViewControllerTrigger: PublishSubject<Void>? {get}
    
    func insertAirline(name: String, country: String?, slogan: String?, headquaters: String?, website: String)
}

class AddAirlinesViewModel: AddAirlinesProtocol{
    
    var dismissViewControllerTrigger: RxSwift.PublishSubject<Void>? = PublishSubject<Void>()
    private let useCase: AirlinesUseCaseProtocol
    private let disposeBag = DisposeBag()
    
    init(useCase: AirlinesUseCaseProtocol = AirlinesUseCase()) {
        self.useCase = useCase
    }
    
    func insertAirline(name: String, country: String?, slogan: String?, headquaters: String?,
                       website: String){
        
        let airlineData = InputData(name: name, country: country, slogan: slogan, head_quaters: headquaters, website: website)
        
        useCase.addAirline(airline: airlineData)
            .subscribe(onNext: { [weak self] result in
                switch result {
                case .success(()):
                    self?.dismissViewControllerTrigger?.onNext(())
                case .failure(let error):
                    print(error)
                }
                
            }).disposed(by: disposeBag)
    }
}
