//
//  ReachableAirportsModel.swift
//  FlightDemo
//
//  Created by Gábor Vass on 05/10/2020.
//  Copyright © 2020 Gábor Vass. All rights reserved.
//

import Foundation
import MapKit

class AirlinesViewModel {
    
    var onAirlinesSorted: (() -> Void)?
    var onError: ((FlightDemoError) -> Void)?
    var airlineDistances: [(key: Airline, value: Double)] = []

    private let airportsProvider: ModelProvider<[Airport]>
    private let flightsProvider: ModelProvider<[Flight]>
    private let airlinesProvider: ModelProvider<[Airline]>

    required init(_ airportProvider: ModelProvider<[Airport]>, flightProvider: ModelProvider<[Flight]>, airlineProvider: ModelProvider<[Airline]>) {
        self.airportsProvider = airportProvider
        self.flightsProvider = flightProvider
        self.airlinesProvider = airlineProvider
    }
    
    private var flights: [Flight] = []
    private var airports: [Airport] = []
    private var airlines: [Airline] = []

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
        group.enter()
        self.loadAirlines { errorResult in
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

    private func loadAirlines(_ then: @escaping (FlightDemoError?) -> Void) {
        self.airlinesProvider.provide { [weak self] result in
            var error: FlightDemoError?
            switch result {
            case .success(let airlines):
                self?.airlines = airlines
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
        
        var distances: [String: Double] = [:]

        self.flights.forEach { flight1 in
            if let destination = airports.enumerated().first(where: {$0.element.id == flight1.arrivalAirportId})?.element {
                var distance: Double = DistanceCalculator.calculateDistance(from: AMS, to: destination)
                if let value = distances[flight1.airlineId] {
                    distance += value
                }
                distances[flight1.airlineId] = distance
            }
        }
        distances.sorted(by: { $0.1 < $1.1 })
            .forEach { entry in
                let airline = airlines.filter { $0.id == entry.key }.first!
                self.airlineDistances.append((key: airline, value: entry.value))
        }
        self.onAirlinesSorted?()
    }
}
