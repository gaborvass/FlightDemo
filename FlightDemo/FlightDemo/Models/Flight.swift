//
//  Flight.swift
//  FlightDemo
//
//  Created by Gábor Vass on 03/10/2020.
//  Copyright © 2020 Gábor Vass. All rights reserved.
//

import Foundation

struct Flight {
    let airlineId: String
    let flightNumber: Int
    let departureAirportId: String
    let arrivalAirportId: String
}

extension Flight: Decodable {}
