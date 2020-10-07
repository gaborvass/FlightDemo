//
//  ModelProviderTests.swift
//  FlightDemoTests
//
//  Created by Gábor Vass on 07/10/2020.
//  Copyright © 2020 Gábor Vass. All rights reserved.
//

import Foundation
import XCTest

class FlightsProviderTests: XCTestCase {
    
    func test_fetchFlights_validData_airportsReturned() throws {
        // arrange
        let provider = ModelProvider<[Flight]>("flights.json", dataProvider: LocalDataProvider(test: true))
        let expect = XCTestExpectation()

        // act
        var flights: [Flight]?
        provider.provide { (result) in
            flights = try? result.get()
            expect.fulfill()
        }
        self.wait(for: [expect], timeout: 2)
        
        // assert
        XCTAssertNotNil(flights)
        XCTAssertTrue(flights?.count ?? 0 > 0)
    }

    func test_fetchAirports_invalidData_errorReturned() throws {
        // arrange
        let provider = ModelProvider<[Flight]>("invalid.json", dataProvider: LocalDataProvider(test: true))
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

    func test_fetchFlights_validData_flightHasAllData() throws {
        // arrange
        let provider = ModelProvider<[Flight]>("flights.json", dataProvider: LocalDataProvider(test: true))
        let expect = XCTestExpectation()

        // act
        var flights: [Flight]?
        provider.provide { (result) in
            flights = try? result.get()
            expect.fulfill()
        }
        self.wait(for: [expect], timeout: 2)
        
        // assert
        XCTAssertNotNil(flights)
        XCTAssertTrue(flights?.count ?? 0 > 0)
        let flight: Flight = flights!.first!
        XCTAssertEqual(flight.airlineId, "3O")
        XCTAssertEqual(flight.flightNumber, 2128)
        XCTAssertEqual(flight.departureAirportId, "AMS")
        XCTAssertEqual(flight.arrivalAirportId, "TNG")
    }
}
