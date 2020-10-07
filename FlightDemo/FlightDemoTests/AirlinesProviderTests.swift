//
//  ModelProviderTests.swift
//  FlightDemoTests
//
//  Created by Gábor Vass on 07/10/2020.
//  Copyright © 2020 Gábor Vass. All rights reserved.
//

import Foundation
import XCTest

class AirlinesProviderTests: XCTestCase {
    
    func test_fetchAirlines_validData_airlinesReturned() throws {
        // arrange
        let provider = ModelProvider<[Airline]>("airlines.json", dataProvider: LocalDataProvider(test: true))
        let expect = XCTestExpectation()

        // act
        var airlines: [Airline]?
        provider.provide { (result) in
            airlines = try? result.get()
            expect.fulfill()
        }
        self.wait(for: [expect], timeout: 2)
        
        // assert
        XCTAssertNotNil(airlines)
        XCTAssertTrue(airlines?.count ?? 0 > 0)
    }

    func test_fetchAirlines_invalidData_errorReturned() throws {
        // arrange
        let provider = ModelProvider<[Airline]>("invalid.json", dataProvider: LocalDataProvider(test: true))
        let expect = XCTestExpectation()
        
        // act
        var error: FlightDemoError?
        provider.provide { (result) in
            switch result {
            case .failure(let failure):
                error = failure
            default:
                break
            }
            expect.fulfill()
        }
        self.wait(for: [expect], timeout: 2)

        // assert
        XCTAssertNotNil(error)
        XCTAssertTrue(error! == .parserError)
    }

    func test_fetchAirlines_validData_airlineHasAllData() throws {
        // arrange
        let provider = ModelProvider<[Airline]>("airlines.json", dataProvider: LocalDataProvider(test: true))
        let expect = XCTestExpectation()

        // act
        var airlines: [Airline]?
        provider.provide { (result) in
            airlines = try? result.get()
            expect.fulfill()
        }
        self.wait(for: [expect], timeout: 2)

        // assert
        XCTAssertNotNil(airlines)
        XCTAssertTrue(airlines?.count ?? 0 > 0)
        let airline: Airline = airlines!.first!
        XCTAssertEqual(airline.id, "3O")
        XCTAssertEqual(airline.name, "Air Arabia Maroc")
    }
}
