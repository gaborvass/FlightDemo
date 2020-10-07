//
//  SettingsProvider.swift
//  FlightDemo
//
//  Created by Gábor Vass on 07/10/2020.
//  Copyright © 2020 Gábor Vass. All rights reserved.
//

import Foundation

enum UnitsOfMeasure: Int {
    case km
    case miles
}

class SettingsProvider {

    enum SettingsKeys: String {
        case unitsOfMeasure = "unitsofmeasure"
    }

    static func unitsOfMeasure() -> UnitsOfMeasure {
        return UnitsOfMeasure(rawValue: UserDefaults.standard.integer(forKey: SettingsKeys.unitsOfMeasure.rawValue)) ?? .km
    }
    
    static func setUnitsOfMeasure(_ to: UnitsOfMeasure) {
        UserDefaults.standard.set(to.rawValue, forKey: SettingsKeys.unitsOfMeasure.rawValue)
    }
}
