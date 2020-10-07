//
//  AirportDetailsViewModel.swift
//  FlightDemo
//
//  Created by Gábor Vass on 03/10/2020.
//  Copyright © 2020 Gábor Vass. All rights reserved.
//

import Foundation
import MapKit

class AirportDetailsViewModel {
    
    var onDataLoaded: ((Result<[Airport], FlightDemoError>) -> Void)?
    var closestAirportFound: ((Airport, Double) -> Void)?
    var onError: ((FlightDemoError) -> Void)?
    var selectedAirport: Airport?

    private let modelProvider: ModelProvider<[Airport]>
    private var airports: [Airport] = []

    required init(_ modelProvider: ModelProvider<[Airport]>) {
        self.modelProvider = modelProvider
    }

    func loadAirportDetails() {
        self.modelProvider.provide { [weak self] result in
            switch result {
            case .success(let airports):
                self?.airports = airports
                self?.calculateClosestAirport()
            case .failure(let error):
                self?.onError?(error)
            }
        }
    }

    private func findAirports(degree: Double) -> [Airport] {
        guard let selectedAirport = self.selectedAirport else {
            return []
        }
        let airportsNearby = self.airports.filter {
            let latDiff = abs(abs(selectedAirport.latitude) - abs($0.latitude))
            let longDiff = abs(abs(selectedAirport.longitude) - abs($0.longitude))
            return latDiff < degree && latDiff != degree && longDiff < degree && longDiff != 0
        }
        if airportsNearby.count == 0 {
            return findAirports(degree: degree + 1)
        } else {
            return airportsNearby
        }
    }
    
    private func calculateClosestAirport() {
        guard let selectedAirport = self.selectedAirport else {
            return
        }

        var shortest: Double = Double.greatestFiniteMagnitude
        var closestAirport: Airport?

        findAirports(degree: 1).forEach { airport in
            let distance = DistanceCalculator.calculateDistance(from: selectedAirport, to: airport)
            if distance < shortest {
                shortest = distance
                closestAirport = airport
            }
        }
        if let closestAirport = closestAirport {
            self.closestAirportFound?(closestAirport, shortest)
        }
    }
}
