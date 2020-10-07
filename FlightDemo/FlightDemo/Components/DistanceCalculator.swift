//
//  DistanceCalculator.swift
//  FlightDemo
//
//  Created by Gábor Vass on 06/10/2020.
//  Copyright © 2020 Gábor Vass. All rights reserved.
//

import Foundation
import CoreLocation

class DistanceCalculator {

    private static var cache: [String: Double] = [:]

    static func calculateDistance(from: Airport, to: Airport) -> Double {
        let key = [from.id, to.id]
        
        if let distance = cache[key.joined()] {
            return distance
        }
        if let distance = cache[key.reversed().joined()] {
            return distance
        }

        let distance = applyUnitOfMeasure(distance: to.coordinate.distance(from: from.coordinate) / 1000)
        cache[key.joined()] = distance
        return distance
    }

    static func invalidateCache() {
        cache = [:]
    }

    private static func applyUnitOfMeasure(distance: Double) -> Double {
        if SettingsProvider.unitsOfMeasure() == .miles {
            // formula to calculate miles from km
            return distance / 1.609
        }
        return distance
    }
}
