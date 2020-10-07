//
//  Airports.swift
//  FlightDemo
//
//  Created by Gábor Vass on 03/10/2020.
//  Copyright © 2020 Gábor Vass. All rights reserved.
//

import Foundation
import MapKit

struct Airport {
    let id: String
    let name: String
    let city: String
    let latitude: Double
    let longitude: Double
    let countryId: String
}

extension Airport: Decodable {}

extension Airport: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// getter to get coordinate
extension Airport {
    var coordinate: CLLocation {
        CLLocation.init(latitude: self.latitude, longitude: self.longitude)
    }
}
