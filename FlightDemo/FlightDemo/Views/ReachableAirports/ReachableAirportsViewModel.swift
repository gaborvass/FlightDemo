//
//  ReachableAirportsModel.swift
//  FlightDemo
//
//  Created by Gábor Vass on 05/10/2020.
//  Copyright © 2020 Gábor Vass. All rights reserved.
//

import Foundation
import MapKit

class ReachableAirportsViewModel {

    var onAirportsSorted: (() -> Void)?
    var onError: ((FlightDemoError) -> Void)?

    private let airportsProvider: ModelProvider<[Airport]>
    private let flightsProvider: ModelProvider<[Flight]>

    required init(_ airportProvider: ModelProvider<[Airport]>, flightProvider: ModelProvider<[Flight]>) {
        self.airportsProvider = airportProvider
        self.flightsProvider = flightProvider
    }

    var reachableAirports: [(key: Airport, value: Double)] = []
    private var flights: [Flight] = []
    private var airports: [Airport] = []

    func load() {
        let group = DispatchGroup.init()
        var error: FlightDemoError?
        group.enter()
        self.loadAirports { errorResult in
            error = errorResult
            group.leave()
        }
        group.enter()
        self.loadFlights { errorResult in
            error = errorResult
            group.leave()
        }
        group.notify(queue: DispatchQueue.main) {
            guard error == nil else {
                self.onError?(error!)
                return
            }
            self.calculateDistances()
        }
    }

    private func loadAirports(_ then: @escaping (FlightDemoError?) -> Void) {
        self.airportsProvider.provide { [weak self] result in
            var error: FlightDemoError?
            switch result {
            case .success(let airports):
                self?.airports = airports
            case .failure(let failure):
                error = failure
            }
            then(error)
        }
    }

    private func loadFlights(_ then: @escaping (FlightDemoError?) -> Void) {
        self.flightsProvider.provide { [weak self] result in
            var error: FlightDemoError?
            switch result {
            case .success(let flights):
                self?.flights = flights
            case .failure(let failure):
                error = failure
            }
            then(error)
        }
    }

    private func calculateDistances() {
        let AMS = self.airports.filter {
            $0.id == "AMS"
        }.first!
        // create set to remove duplicates
        let arrivalAirports = Array(Set(self.flights.map { $0.arrivalAirportId }))
        self.reachableAirports = Dictionary.init(uniqueKeysWithValues: airports
            .filter { arrivalAirports.contains($0.id)}
            .map { ($0, DistanceCalculator.calculateDistance(from: AMS, to: $0)) })
            .sorted { $0.1 < $1.1 }
        self.onAirportsSorted?()
    }
}
