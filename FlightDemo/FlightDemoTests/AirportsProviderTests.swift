//
//  ModelProviderTests.swift
//  FlightDemoTests
//
//  Created by Gábor Vass on 07/10/2020.
//  Copyright © 2020 Gábor Vass. All rights reserved.
//

import Foundation
import XCTest

class AirportsProviderTests: XCTestCase {
    
    func test_fetchAirports_validData_airportsReturned() throws {
        // arrange
        let provider = ModelProvider<[Airport]>("airports.json", dataProvider: LocalDataProvider(test: true))
        let expect = XCTestExpectation()

        // act
        var airports: [Airport]?
        provider.provide { (result) in
            airports = try? result.get()
            expect.fulfill()
        }
        self.wait(for: [expect], timeout: 2)
        
        // assert
        XCTAssertNotNil(airports)
        XCTAssertTrue(airports?.count ?? 0 > 0)
    }

    func test_fetchAirports_invalidData_errorReturned() throws {
        // arrange
        let provider = ModelProvider<[Airport]>("invalid.json", dataProvider: LocalDataProvider(test: true))
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

    func test_fetchAirlines_validData_airportHasAllData() throws {
        // arrange
        let provider = ModelProvider<[Airport]>("airports.json", dataProvider: LocalDataProvider(test: true))
        let expect = XCTestExpectation()

        // act
        var airports: [Airport]?
        provider.provide { (result) in
            airports = try? result.get()
            expect.fulfill()
        }
        self.wait(for: [expect], timeout: 2)

        // assert
        XCTAssertNotNil(airports)
        XCTAssertTrue(airports?.count ?? 0 > 0)
        let airport: Airport = airports!.first!
        XCTAssertEqual(airport.id, "AAL")
        XCTAssertEqual(airport.name, "Aalborg Airport")
        XCTAssertEqual(airport.city, "Aalborg")
        XCTAssertEqual(airport.latitude, 57.08655)
        XCTAssertEqual(airport.longitude, 9.872241)
        XCTAssertEqual(airport.countryId, "DK")
    }
}
