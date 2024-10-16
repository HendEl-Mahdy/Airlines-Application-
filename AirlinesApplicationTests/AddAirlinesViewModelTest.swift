//
//  AddAirlinesViewModelTest.swift
//  AirlinesApplicationTests
//
//  Created by HendEl-Mahdy on 27/08/2024.
//

import XCTest
import RxSwift

@testable import AirlinesApplication

final class AddAirlinesViewModelTest: XCTestCase {
    private var sut: AddAirlinesProtocol?
    private var useCase: AirlinesUseCaseMock?
    private let disposeBag = DisposeBag()
    
    override func setUpWithError() throws {
        useCase = AirlinesUseCaseMock(isSuccessfull: true)
        let nonOptionalUseCase = try XCTUnwrap(useCase)
        sut = AddAirlinesViewModel(useCase: nonOptionalUseCase)
    }
    
    override func tearDownWithError() throws {
        useCase = nil
        sut = nil
    }
    
    func testInsertAirline_withInvalidData_shouldFireObserver() {
        
        let expectation = XCTestExpectation(description: "wait for validation")
        
        guard let nameObservable = sut?.nameObservable,
              let websiteObservable = sut?.websiteObservable else {
            XCTFail("Observables should not be nil")
            return
        }
        
        let zipObserver = Observable.zip(nameObservable, websiteObservable)
        
        zipObserver
            .subscribe(onNext: { result in
                expectation.fulfill()
            })
            .disposed(by: disposeBag)
        
        sut?.insertAirline(name: Constants.emptyString, country: "United States", slogan: "Fly High with Us", headquaters: "New York, USA", website: "www.airwave")
        
        wait(for: [expectation], timeout: 0.2)
    }
    
    func testInsertAirline_withInvalidName_shouldFireObserver() {
        
        let expectation = XCTestExpectation(description: "wait for validation")
        
        guard let nameObservable = sut?.nameObservable else {
            XCTFail("Observables should not be nil")
            return
        }
        
        nameObservable
            .subscribe(onNext: { result in
                expectation.fulfill()
            })
            .disposed(by: disposeBag)
        
        sut?.websiteObservable
            .subscribe(onNext: { result in
                XCTFail("Observables should be nil")
            })
            .disposed(by: disposeBag)
        
        sut?.insertAirline(name: Constants.emptyString, country: "United States", slogan: "Fly High with Us", headquaters: "New York, USA", website: "www.airwave.com")
        
        wait(for: [expectation], timeout: 0.2)
    }
    
    func testInsertAirline_withInvalidWebsite_shouldFireObserver() {
        
        let expectation = XCTestExpectation(description: "wait for validation")
        
        guard let websiteObservable = sut?.websiteObservable else {
            XCTFail("Observables should not be nil")
            return
        }
        
        sut?.nameObservable
            .subscribe(onNext: { result in
                XCTFail("Observables should be nil")
            })
            .disposed(by: disposeBag)
        
        websiteObservable
            .subscribe(onNext: { result in
                expectation.fulfill()
            })
            .disposed(by: disposeBag)
        
        sut?.insertAirline(name: "Airwave Airlines", country: "United States", slogan: "Fly High with Us", headquaters: "New York, USA", website: "www.airwave")
        
        wait(for: [expectation], timeout: 0.2)
    }
    
    func testInsertAirline_withValidData_shouldFireSuccessObserver() {
        
        let expectation = XCTestExpectation(description: "wait for validation")
        guard let dismissViewControllerTrigger = sut?.dismissViewControllerTrigger else {
            XCTFail("Observables should not be nil")
            return
        }
        
        sut?.nameObservable
            .subscribe(onNext: { result in
                XCTFail("Observables should be nil")
            })
            .disposed(by: disposeBag)
        
        sut?.websiteObservable
            .subscribe(onNext: { result in
                XCTFail("Observables should be nil")
            })
            .disposed(by: disposeBag)
        
        dismissViewControllerTrigger
            .subscribe(onNext: { result in
                switch result{
                case .success(_):
                    expectation.fulfill()
                case .failure(let error):
                    XCTAssertNil(error)
                }
            })
            .disposed(by: disposeBag)
        
        sut?.insertAirline(name: "Airwave Airlines", country: "United States", slogan: "Fly High with Us", headquaters: "New York, USA", website: "www.airwave.com")
        
        wait(for: [expectation], timeout: 0.2)
    }
    
    func testInsertAirline_withValidData_shouldFireFailureObserver() {
        useCase = AirlinesUseCaseMock(isSuccessfull: false)
        do {
            let nonOptionalUseCase = try XCTUnwrap(useCase)
            sut = AddAirlinesViewModel(useCase: nonOptionalUseCase)
        } catch {
            XCTFail("useCase should not be nil: \(error)")
            return
        }
        
        let expectation = XCTestExpectation(description: "wait for validation")
        
        guard let dismissViewControllerTrigger = sut?.dismissViewControllerTrigger else {
            XCTFail("Observables should not be nil")
            return
        }
        
        sut?.nameObservable
            .subscribe(onNext: { result in
                XCTFail("Observables should be nil")
            })
            .disposed(by: disposeBag)
        
        sut?.websiteObservable
            .subscribe(onNext: { result in
                XCTFail("Observables should be nil")
            })
            .disposed(by: disposeBag)
        
        dismissViewControllerTrigger
            .subscribe(onNext: { result in
                switch result{
                case .success(let data):
                    XCTAssertNil(data)
                case .failure(_):
                    expectation.fulfill()
                }
            })
            .disposed(by: disposeBag)
        
        sut?.insertAirline(name: "Airwave Airlines", country: "United States", slogan: "Fly High with Us", headquaters: "New York, USA", website: "www.airwave.com")
        
        wait(for: [expectation], timeout: 0.2)
    }
}
