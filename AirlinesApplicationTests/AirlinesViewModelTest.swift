//
//  AirlinesViewModelTest.swift
//  AirlinesApplicationTests
//
//  Created by HendEl-Mahdy on 25/08/2024.
//

import XCTest
import RxSwift

@testable import  AirlinesApplication

final class AirlinesViewModelTest: XCTestCase {
    private var sut: AirlinesProtocol?
    private var useCase: AirlinesUseCaseMock?
    private let disposeBag = DisposeBag()
    
    override func setUpWithError() throws {
        useCase = AirlinesUseCaseMock(isSuccessfull: true)
        let nonOptionalUseCase = try XCTUnwrap(useCase)
        sut = AirlinesViewModel(airlinesUseCase: nonOptionalUseCase)
    }
    
    override func tearDownWithError() throws {
        useCase = nil
        sut = nil
    }
    
    func testGetNumberOfSections_returnCorrectNumberOfSections(){
        let numberOfSections = sut?.getNumberOfSections()
        
        XCTAssertEqual(numberOfSections, Constants.numberOfSections, "getNumberOfSections should return the correct number of sections.")
    }
    
    func testGetNumberOfRows_withAirlinesArray_returnCorrectNumberOfRows() {
        sut?.getAirlines()
        let numberOfRows = sut?.getNumberOfRows()
        
        XCTAssertEqual(numberOfRows, mockData.count, "getNumberOfRows should return the correct number of rows based on the airlinesArray count.")
    }
    
    func testGetAirlineData_validIndex_returnCorrectAirlineData() {
        let dataModel = DataModel(name: "Airwave Airlines", country: "United States", slogan: "Fly High with Us", head_quaters: "New York, USA", website: "www.airwave.com")
        
        sut?.getAirlines()
        
        let airlineData = sut?.getAirlineData(index: 0)
        
        XCTAssertEqual(airlineData, dataModel, "getAirlineData should return the correct data for the given index.")
    }
    
    func testGetAirlines_shouldFireSuccessObserver() throws {
        let expectaion = XCTestExpectation(description: "wait for data")
        
        sut?.getAirlines()
        sut?.airlinesObservable.subscribe(onNext: { result  in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data)
                expectaion.fulfill()
            case .failure(let error):
                XCTAssertNil(error)
            }
        }).disposed(by: disposeBag)
        
        wait(for: [expectaion],timeout: 0.2)
        
    }
    
    func testGetAirlines_shouldFireFailureObserver() throws {
        useCase = AirlinesUseCaseMock(isSuccessfull: false)
        let nonOptionalUseCase = try XCTUnwrap(useCase)
        sut = AirlinesViewModel(airlinesUseCase: nonOptionalUseCase)
        
        let expectaion = XCTestExpectation(description: "wait for data")
        
        sut?.getAirlines()
        sut?.airlinesObservable.subscribe(onNext: { result  in
            switch result {
            case .success(let data):
                XCTAssertNil(data)
            case .failure(let error):
                XCTAssertNotNil(error)
                expectaion.fulfill()
            }
        }).disposed(by: disposeBag)
        
        wait(for: [expectaion],timeout: 0.2)
    }
    
    func testSearchForName_withEmptyString_shouldReturnAllAirlinesData(){
        let searchName = Constants.emptyString
        
        sut?.searchForName(for: searchName)
        let numberOfAilines = sut?.getNumberOfRows()
        
        XCTAssertEqual(numberOfAilines, mockData.count, "search for empty string should return all Airlines")
        
    }
    
    func testSearchForName_lastCharacterHasSpace_shouldNumberOfRowsNotChanaged(){
        let searchName = Constants.space
        sut?.getAirlines()
        
        let oldNumberOfRows = sut?.getNumberOfRows()
        sut?.searchForName(for: searchName)
        
        let newNumberOfRows  = sut?.getNumberOfRows()
        
        XCTAssertEqual(oldNumberOfRows, newNumberOfRows, "searchForName should take no action ")
    }
    
    func testSearchForName_WithLessThanTwoCharacter_shouldNumberOfRowsNotChanged(){
        let searchName = "Ai"
        
        let oldNumberOfRows = sut?.getNumberOfRows()
        sut?.searchForName(for: searchName)
        
        let newNumberOfRows  = sut?.getNumberOfRows()
        
        XCTAssertEqual(oldNumberOfRows, newNumberOfRows, "searchForName should take no action ")
    }
    
    func testSearchForName_WithGreaterThanTwoCharacter_shouldReturnNotNil(){
        let searchName = "Air"
        sut?.getAirlines()
        
        let oldNumberOfRows = sut?.getNumberOfRows()
        sut?.searchForName(for: searchName)
        
        let newNumberOfRows  = sut?.getNumberOfRows()
        
        XCTAssertGreaterThan(oldNumberOfRows!, newNumberOfRows!)
    }
    
    func testSearchForName_WithGreaterThanTwoCharacter_shouldFireSuccessObserver(){
        let expectaion = XCTestExpectation(description: "wait for search")
        let searchName = "Air"
        
        sut?.searchForName(for: searchName)
        sut?.airlinesObservable.subscribe(onNext: { result  in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data)
                expectaion.fulfill()
            case .failure(let error):
                XCTAssertNil(error)
            }
        }).disposed(by: disposeBag)
        
        wait(for: [expectaion],timeout: 0.2)
        
    }
    
    func testSearchForName_WithGreaterThanTwoCharacter_shouldFireFailureObserver(){
        useCase = AirlinesUseCaseMock(isSuccessfull: false)
        do {
            let nonOptionalUseCase = try XCTUnwrap(useCase)
            sut = AirlinesViewModel(airlinesUseCase: nonOptionalUseCase)
        } catch {
            XCTFail("useCase should not be nil: \(error)")
            return
        }
        
        let expectaion = XCTestExpectation(description: "wait for search")
        let searchName = "Air"
        
        sut?.searchForName(for: searchName)
        sut?.airlinesObservable.subscribe(onNext: { result  in
            switch result {
            case .success(let data):
                XCTAssertNil(data)
            case .failure(let error):
                XCTAssertNotNil(error)
                expectaion.fulfill()
            }
        }).disposed(by: disposeBag)
        
        wait(for: [expectaion],timeout: 0.2)
    }
}
