//
//  AirportOverlayView.swift
//  FlightDemo
//
//  Created by Gábor Vass on 03/10/2020.
//  Copyright © 2020 Gábor Vass. All rights reserved.
//

import Foundation
import MapKit

class AirportAnnotation: NSObject, MKAnnotation {
    let airport: Airport

    var coordinate: CLLocationCoordinate2D {
        airport.coordinate.coordinate
    }
    var title: String? {
        airport.name
    }

    var subtitle: String? {
        airport.city
    }

    required init(_ airport: Airport) {
        self.airport = airport
    }
}

class AirportOverlayView: MKAnnotationView {

    override var annotation: MKAnnotation? {
        willSet {
            canShowCallout = true
            image = UIImage.init(named: "airport_icon")
            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
    }
    
    override func tintColorDidChange() {
        image = UIImage.init(named: "airport_icon")
    }
}
