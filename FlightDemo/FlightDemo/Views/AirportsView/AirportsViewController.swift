//
//  AirportsViewController.swift
//  FlightDemo
//
//  Created by Gábor Vass on 03/10/2020.
//  Copyright © 2020 Gábor Vass. All rights reserved.
//

import Foundation
import UIKit

class AirportsViewController: UINavigationController, UINavigationControllerDelegate {

    private let mapView: MapViewController
    private let airportDetailView: AirportDetailsViewController

    required init(mapView: MapViewController, detailsView: AirportDetailsViewController) {
        self.mapView = mapView
        self.airportDetailView = detailsView
        super.init(nibName: nil, bundle: nil)
        self.setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabBarItem()
        self.pushViewController(self.mapView, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setupTabBarItem()
        super.viewWillAppear(animated)
    }

    private func setupTabBarItem() {
        let tabBarItem = UITabBarItem.init(
            title: NSLocalizedString("Airports",
            comment: "Airports View Title"),
            image: UIImage.init(named: "airport_icon"),
            selectedImage: nil)
        self.tabBarItem = tabBarItem
    }
    
    private func setup() {
        self.mapView.onAirportSelected = { [weak self] airport in
            self?.showAirportDetails(airport)
        }
    }

    private func showAirportDetails(_ airport: Airport) {
        self.airportDetailView.selectedAirport = airport
        self.pushViewController(self.airportDetailView, animated: true)
    }
}
