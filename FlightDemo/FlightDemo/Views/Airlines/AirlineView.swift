//
//  AirlineView.swift
//  FlightDemo
//
//  Created by Gábor Vass on 03/10/2020.
//  Copyright © 2020 Gábor Vass. All rights reserved.
//

import Foundation
import UIKit

class AirlineView: UIView {

    private let idLabel = UILabel()
    private let nameLabel = UILabel()
    private let distanceLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateContent(_ airline: Airline, distance: Double) {
        self.idLabel.text = airline.id
        self.nameLabel.text = airline.name
        self.distanceLabel.text = DistanceFormatter.format(distance)
    }

    private func setup() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setupIdLabel()
        self.setupNameLabel()
        self.setupDistanceLabel()
    }

    private func setupIdLabel() {
        self.idLabel.translatesAutoresizingMaskIntoConstraints = false
        self.idLabel.font = UIDesign.Fonts.label
        self.idLabel.textColor = UIDesign.Colors.label
        self.idLabel.accessibilityIdentifier = "airline_id"
        self.addSubview(self.idLabel)
        NSLayoutConstraint.activate([
            self.idLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            self.idLabel.widthAnchor.constraint(equalToConstant: 100),
            self.idLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            self.idLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }

    private func setupNameLabel() {
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.nameLabel.font = UIDesign.Fonts.label
        self.nameLabel.textColor = UIDesign.Colors.label
        self.nameLabel.accessibilityIdentifier = "airline_name"
        self.addSubview(self.nameLabel)
        NSLayoutConstraint.activate([
            self.nameLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            self.nameLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            self.nameLabel.topAnchor.constraint(equalTo: self.idLabel.bottomAnchor, constant: 8),
            self.nameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }

    private func setupDistanceLabel() {
        self.distanceLabel.translatesAutoresizingMaskIntoConstraints = false
        self.distanceLabel.font = UIDesign.Fonts.label
        self.distanceLabel.textColor = UIDesign.Colors.label
        self.distanceLabel.textAlignment = .right
        self.distanceLabel.accessibilityIdentifier = "distance_label"
        self.addSubview(self.distanceLabel)
        NSLayoutConstraint.activate([
            self.distanceLabel.leadingAnchor.constraint(equalTo: self.idLabel.trailingAnchor, constant: 8),
            self.distanceLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            self.distanceLabel.topAnchor.constraint(equalTo: self.idLabel.topAnchor),
            self.distanceLabel.heightAnchor.constraint(equalTo: self.idLabel.heightAnchor)
        ])
    }
}
