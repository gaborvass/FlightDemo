//
//  FlightDemoUITests.swift
//  FlightDemoUITests
//
//  Created by Gábor Vass on 03/10/2020.
//  Copyright © 2020 Gábor Vass. All rights reserved.
//

import XCTest

class DestinationViewTests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func test_destinationsViewSelected_listContainsDestinations() throws {
        // Arrange
        let app = XCUIApplication()
        app.launchArguments = ["ui-testing"]
        app.launch()

        // Act
        app.tabBars.buttons["Destinations"].tap()
        
        let tablesQuery = app.tables
                
        let firstRow = tablesQuery.cells.allElementsBoundByIndex[0]
        let airportName = firstRow.staticTexts["airport_name"].label
        
        XCTAssertEqual(airportName, "Rotterdam The Hague Airport")
    }
}
