//
//  SettingsViewModel.swift
//  FlightDemo
//
//  Created by Gábor Vass on 06/10/2020.
//  Copyright © 2020 Gábor Vass. All rights reserved.
//

import Foundation

class SettingsViewModel {
    
    func currentValue() -> UnitsOfMeasure {
        return SettingsProvider.unitsOfMeasure()
    }
    
    func updateValue(_ to: UnitsOfMeasure) {
        SettingsProvider.setUnitsOfMeasure(to)
        DistanceCalculator.invalidateCache()
    }
}

