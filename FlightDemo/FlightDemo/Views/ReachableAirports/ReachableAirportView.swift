//
//  AirportView.swift
//  FlightDemo
//
//  Created by Gábor Vass on 05/10/2020.
//  Copyright © 2020 Gábor Vass. All rights reserved.
//

import Foundation
import UIKit

class AirportView: UIView {
    
    private let airportTitleLabel = UILabel()
    private let distanceLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateContent(_ with: (key: Airport, value: Double)) {
        self.airportTitleLabel.text = with.key.name
        self.distanceLabel.text = DistanceFormatter.format(with.value)
    }

    private func setup() {
        self.translatesAutoresizingMaskIntoConstraints = false

        self.setupAirportTitle()
        self.setupDistance()
    }

    private func setupAirportTitle() {
        self.airportTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.airportTitleLabel.font = UIDesign.Fonts.label
        self.airportTitleLabel.textColor = UIDesign.Colors.label
        self.airportTitleLabel.accessibilityIdentifier = "airport_name"
        self.addSubview(self.airportTitleLabel)
        NSLayoutConstraint.activate([
            self.airportTitleLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            self.airportTitleLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            self.airportTitleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            self.airportTitleLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }

    private func setupDistance() {
        self.distanceLabel.translatesAutoresizingMaskIntoConstraints = false
        self.distanceLabel.font = UIDesign.Fonts.label
        self.distanceLabel.textColor = UIDesign.Colors.label
        self.distanceLabel.accessibilityIdentifier = "airport_distance"
        self.addSubview(self.distanceLabel)
        NSLayoutConstraint.activate([
            self.distanceLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            self.distanceLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            self.distanceLabel.topAnchor.constraint(equalTo: self.airportTitleLabel.bottomAnchor, constant: 8),
            self.distanceLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
