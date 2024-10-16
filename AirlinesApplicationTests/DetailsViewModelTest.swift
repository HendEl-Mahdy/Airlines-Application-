//
//  DetailsViewModelTest.swift
//  AirlinesApplicationTests
//
//  Created by HendEl-Mahdy on 27/08/2024.
//

import XCTest
import RxSwift
@testable import AirlinesApplication

final class DetailsViewModelTest: XCTestCase {
    private var sut: DetailsProtocol?
    private let disposeBag = DisposeBag()
    
    override func setUpWithError() throws {
        
        let dataModel = DataModel(name: "Airwave Airlines", country: "United States", slogan: "Fly High with Us", head_quaters: "New York, USA", website: "www.airwave.com")
        
        sut = DetailsViewModel(airline: dataModel)
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testValidateText_validInput_shouldReturnFalse() throws {
        let output = sut?.validateText()
        
        XCTAssertFalse(output!, "validateText should be false")
    }
    
    func testValidateText_emptyString_shouldReturnTrue() throws {
        let dataModel = DataModel(name: "Airwave Airlines", country: "United States", slogan: "Fly High with Us", head_quaters: "", website: "www.airwave.com")
        
        sut = DetailsViewModel(airline: dataModel)
        let output = sut?.validateText()
        
        XCTAssertTrue(output!, "validateText should be true")
        
    }
    
    func testValidateText_nilValue_shouldReturnTrue() throws {
        let dataModel = DataModel(name: "Airwave Airlines", country: "United States", slogan: "Fly High with Us", head_quaters: nil, website: "www.airwave.com")
        
        sut = DetailsViewModel(airline: dataModel)
        let output = sut?.validateText()
        
        XCTAssertTrue(output!, "validateText should be true")
        
    }
    
    func testHandleUrl_emptyString_ShouldReturnNotNil(){
        let dataModel = DataModel(name: "Airwave Airlines", country: "United States", slogan: "Fly High with Us", head_quaters: "New York, USA", website: "")
        let expectaion = XCTestExpectation(description: "wait for url handling")
        
        sut = DetailsViewModel(airline: dataModel)
        
        sut?.emptyURLDriver?.drive(onNext: { url in
            XCTAssertNotNil(url)
            expectaion.fulfill()
        }).disposed(by: disposeBag)
        sut?.handleUrl()
        
        wait(for: [expectaion],timeout: 0.2)
    }
    
    func testHandleUrl_validURL_ShouldReturnURLRequest(){
        let expectaion = XCTestExpectation(description: "wait for url handling")
        
        sut?.websiteURLDriver?.drive(onNext: { url in
            XCTAssertEqual(url.url?.absoluteString, "www.airwave.com")
            expectaion.fulfill()
        }).disposed(by: disposeBag)
        sut?.handleUrl()
        
        wait(for: [expectaion],timeout: 0.2)
    }
    
}
