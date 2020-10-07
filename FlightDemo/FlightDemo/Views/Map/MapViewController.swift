//
//  MapView.swift
//  FlightDemo
//
//  Created by Gábor Vass on 03/10/2020.
//  Copyright © 2020 Gábor Vass. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class MapViewController: UIViewController {

    var onAirportSelected: ((Airport) -> Void)?

    private let model: MapViewModel

    required init(_ model: MapViewModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var mapView: MKMapView = {
        let view = MKMapView.init()
        view.register(AirportOverlayView.self, forAnnotationViewWithReuseIdentifier: "airport")
        view.delegate = self
        return view
    }()

    private lazy var stateManager: ViewStateManager = {
        return ViewStateManager(parent: self)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupModel()
        self.setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        super.viewWillAppear(animated)
        self.stateManager.state = .showLoading
        self.model.load()
    }

    private func showFurthestAirports(airport1: Airport, airport2: Airport) {
        let line = MKPolyline.init(coordinates: [
            airport1.coordinate.coordinate,
            airport2.coordinate.coordinate],
                                   count: 2)
        self.mapView.addOverlay(line)
    }
    
    private func generateAnnotations() {
        self.mapView.addAnnotations(self.model.airports.map { airport in
            let ann = AirportAnnotation(airport)
            return ann
        })
    }

    private func setupView() {
        self.mapView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.mapView)
        NSLayoutConstraint.activate([
            self.mapView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.mapView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.mapView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.mapView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func setupModel() {
        self.model.onDataLoaded = { [weak self] in
            self?.stateManager.state = .hideLoading
            self?.generateAnnotations()
        }
        self.model.onFurthestAirportsFound = { [weak self] (airport1, airport2) in
            self?.showFurthestAirports(airport1: airport1, airport2: airport2)
        }
        self.model.onError = { [weak self] error in
            self?.stateManager.state = .showError(error)
        }
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay.isKind(of: MKPolyline.self) {
            let renderer = MKPolylineRenderer.init(overlay: overlay)
            renderer.strokeColor = UIColor.red
            renderer.lineWidth = 2
            return renderer
        }
        return MKOverlayRenderer(overlay: overlay)
    }

    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if let airportAnnotation = view.annotation as? AirportAnnotation {
            self.onAirportSelected?(airportAnnotation.airport)
        }
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "airport")
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "airport")
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        return annotationView
    }
}
