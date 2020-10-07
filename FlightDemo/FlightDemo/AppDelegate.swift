//
//  AppDelegate.swift
//  FlightDemo
//
//  Created by Gábor Vass on 03/10/2020.
//  Copyright © 2020 Gábor Vass. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)

        // create data provider, if executing UI tests, will use local data
        var dataProvider: DataProvider = RemoteDataProvider()
        #if DEBUG
        if CommandLine.arguments.contains("ui_testing") {
            dataProvider = LocalDataProvider()
        }
        #endif

        let airportProvider = ModelProvider<[Airport]>("https://flightassets.datasavannah.com/test/airports.json", dataProvider: dataProvider)
        
        let flightProvider = ModelProvider<[Flight]>("https://flightassets.datasavannah.com/test/flights.json", dataProvider: dataProvider)

        let airlineProvider = ModelProvider<[Airline]>("https://flightassets.datasavannah.com/test/airlines.json", dataProvider: dataProvider)

        // setup MapView
        let mapViewModel = MapViewModel(airportProvider)
        let mapView = MapViewController(mapViewModel)
        
        // setup AirportDetailsView
        let airportDetailsModel = AirportDetailsViewModel(airportProvider)
        let airportDetailsView = AirportDetailsViewController(airportDetailsModel)
        
        // setup first tab -> add MapView and AirportDetailsView
        let airportsView = AirportsViewController(mapView: mapView, detailsView: airportDetailsView)
        
        // setup ReachableAirportsView
        let reachableAirportsViewModel = ReachableAirportsViewModel(airportProvider, flightProvider: flightProvider)
        let reachableAirportsView = ReachableAirportsView(reachableAirportsViewModel)

        // setup AirlinesView
        let airlinesViewModel = AirlinesViewModel(airportProvider, flightProvider: flightProvider, airlineProvider: airlineProvider)
        let airlinesView = AirlinesViewController(airlinesViewModel)

        // setup SettingsView
        let settingsView = SettingsViewController()
        
        // setup TabView
        let mainView = MainView()
        mainView.viewControllers = [airportsView, reachableAirportsView, airlinesView, settingsView]
        
        window?.rootViewController = mainView
        window?.makeKeyAndVisible()

        return true
    }
}
