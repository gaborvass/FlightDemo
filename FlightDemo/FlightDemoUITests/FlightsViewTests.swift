//
//  FlightDemoUITests.swift
//  FlightDemoUITests
//
//  Created by Gábor Vass on 03/10/2020.
//  Copyright © 2020 Gábor Vass. All rights reserved.
//

import XCTest

class FlightViewTests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func test_flightsViewSelected_listContainsFlights() throws {
        // Arrange
        let app = XCUIApplication()
        app.launchArguments = ["ui-testing"]
        app.launch()

        // Act
        app.tabBars.buttons["Airlines"].tap()
        
        let tablesQuery = app.tables
        
        let firstRow = tablesQuery.cells.allElementsBoundByIndex[0]
        let airlineID = firstRow.staticTexts["airline_id"].label
        let airlineName = firstRow.staticTexts["airline_name"].label

        XCTAssertEqual(airlineID, "PK")
        XCTAssertEqual(airlineName, "Pakistan International Airlines")
    }

}
