//
//  DistanceFormatter.swift
//  FlightDemo
//
//  Created by Gábor Vass on 06/10/2020.
//  Copyright © 2020 Gábor Vass. All rights reserved.
//

import Foundation

class DistanceFormatter {

    // cache NumberFormmatter instance for performance reason
    private static var formatter: NumberFormatter = {
        let numberformatter = NumberFormatter()
        numberformatter.maximumFractionDigits = 0
        return numberformatter
    }()

    static func format(_ distance: Double) -> String {
        let formattedValue = formatter.string(from: NSNumber(value: distance)) ?? "\(distance)"
        let format = SettingsProvider.unitsOfMeasure() == .km ?
            NSLocalizedString("km", comment: "Metric unit with placeholder") :
            NSLocalizedString("miles", comment: "Imperial Unit with placeholder")
        return String(format: format, formattedValue)
    }
}
