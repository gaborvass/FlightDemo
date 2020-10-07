//
//  MapViewModel.swift
//  FlightDemo
//
//  Created by Gábor Vass on 03/10/2020.
//  Copyright © 2020 Gábor Vass. All rights reserved.
//

import Foundation
import MapKit

class MapViewModel {

    var onDataLoaded: (() -> Void)?
    var onError: ((FlightDemoError) -> Void)?
    var onFurthestAirportsFound: ((Airport, Airport) -> Void)?
    var airports: [Airport] = []

    private let modelProvider: ModelProvider<[Airport]>

    required init(_ modelProvider: ModelProvider<[Airport]>) {
        self.modelProvider = modelProvider
    }
    
    func load() {
        self.modelProvider.provide { [weak self] result in
            var error: FlightDemoError?
            switch result {
            case .success(let airports):
                self?.airports = airports
            case .failure(let failure):
                error = failure
            }
            guard error == nil else {
                self?.onError?(error!)
                return
            }
            self?.onDataLoaded?()
            self?.calculateFurthestAirports()
        }
    }

    // logic tries to find the closest opposite coordinate
    private func calculateFurthestAirports() {
        var max1, max2: Airport?
        var minDiffTo180: Double = 5
        var minLatitudeDiff: Double = 45
        self.airports.forEach { airport1 in
            self.airports.forEach { airport2 in
                if airport1.longitude > 0 && airport2.longitude < 0 {
                    let diff = 180 - (abs(airport1.longitude) + abs(airport2.longitude))
                    if diff < minDiffTo180 && diff > 0 {
                        minDiffTo180 = diff
                        let latitudeDiff = (abs(abs(airport1.latitude) - abs(airport2.latitude)))
                        if latitudeDiff < minLatitudeDiff {
                            minLatitudeDiff = latitudeDiff
                            max1 = airport1
                            max2 = airport2
                        }
                    }
                }
            }
        }
        if let max1 = max1, let max2 = max2 {
            self.onFurthestAirportsFound?(max1, max2)
        }
    }
}
