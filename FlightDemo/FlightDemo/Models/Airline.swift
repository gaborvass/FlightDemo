//
//  Airline.swift
//  FlightDemo
//
//  Created by Gábor Vass on 03/10/2020.
//  Copyright © 2020 Gábor Vass. All rights reserved.
//

import Foundation

struct Airline {
    let id: String
    let name: String
}

extension Airline: Decodable {}
extension Airline: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
