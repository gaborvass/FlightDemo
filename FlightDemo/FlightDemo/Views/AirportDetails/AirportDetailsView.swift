//
//  AirportDetailsView.swift
//  FlightDemo
//
//  Created by Gábor Vass on 07/10/2020.
//  Copyright © 2020 Gábor Vass. All rights reserved.
//

import Foundation
import UIKit

class AirportDetailsView: UIView {

    private let airportIdLabel = UILabel()
    private let airportIdText = UILabel()
    private let airportNameLabel = UILabel()
    private let airportNameText = UILabel()
    private let airportCityLabel = UILabel()
    private let airportCityText = UILabel()
    private let airportCountryLabel = UILabel()
    private let airportCountryText = UILabel()
    private let airportLatitudeLabel = UILabel()
    private let airportLatitudeText = UILabel()
    private let airportLongitudeLabel = UILabel()
    private let airportLongitudeText = UILabel()

    private let closestAirportTitle = UILabel()
    private let closestAirportNameLabel = UILabel()
    private let closestAirportNameText = UILabel()
    private let airportDistanceLabel = UILabel()
    private let airportDistanceText = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateContent(_ airport: Airport) {
        self.airportIdText.text = airport.id
        self.airportNameText.text = airport.name
        self.airportCityText.text = airport.city
        self.airportCountryText.text = airport.countryId
        self.airportLatitudeText.text = "\(airport.latitude)"
        self.airportLongitudeText.text = "\(airport.longitude)"
    }

    func updateClosestAirport(_ airport: Airport, distance: Double) {
        self.closestAirportNameText.text = airport.name
        self.airportDistanceText.text = DistanceFormatter.format(distance)
    }

    private func setup() {
        self.translatesAutoresizingMaskIntoConstraints = false
        setupIDRow()
        setupNameRow()
        setupCityRow()
        setupCountryRow()
        setupLatitudeRow()
        setupLongitudeRow()
        setupClosestAirportTitle()
        setupClosestAirportRow()
        setupAirportDistanceRow()

        setupStaticContent()
    }

    private func setupStaticContent() {
        self.airportIdLabel.text = NSLocalizedString("ID:", comment: "Airport ID Label")
        self.airportNameLabel.text = NSLocalizedString("Name:", comment: "Airport Name Label")
        self.airportCityLabel.text = NSLocalizedString("City:", comment: "Airport City Label")
        self.airportCountryLabel.text = NSLocalizedString("Country:", comment: "Airport Country Label")
        self.airportLatitudeLabel.text = NSLocalizedString("Latitude:", comment: "Airport Latitude Label")
        self.airportLongitudeLabel.text =  NSLocalizedString("Longitude:", comment: "Airport Longitude Label")
        self.closestAirportTitle.text =  NSLocalizedString("Closest Airport:", comment: "Closest Airport Label")
        self.closestAirportNameLabel.text =  NSLocalizedString("Name:", comment: "Airport Name Label")
        self.airportDistanceLabel.text =  NSLocalizedString("Distance:", comment: "Airport Distance Label")

    }

    private func setupIDRow() {
        self.airportIdLabel.translatesAutoresizingMaskIntoConstraints = false
        self.airportIdLabel.font = UIDesign.Fonts.label
        self.airportIdLabel.textColor = UIDesign.Colors.label
        self.addSubview(self.airportIdLabel)

        self.airportIdText.translatesAutoresizingMaskIntoConstraints = false
        self.airportIdText.font = UIDesign.Fonts.value
        self.airportIdText.textColor = UIDesign.Colors.value
        self.addSubview(self.airportIdText)

        NSLayoutConstraint.activate([
            self.airportIdLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            self.airportIdLabel.widthAnchor.constraint(equalToConstant: 100),
            self.airportIdLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            self.airportIdLabel.heightAnchor.constraint(equalToConstant: 25),
            self.airportIdText.leadingAnchor.constraint(equalTo: self.airportIdLabel.trailingAnchor, constant: 8),
            self.airportIdText.topAnchor.constraint(equalTo: self.airportIdLabel.topAnchor),
            self.airportIdText.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            self.airportIdText.heightAnchor.constraint(equalTo: self.airportIdLabel.heightAnchor)
        ])
    }

    private func setupNameRow() {
        self.airportNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.airportNameLabel.font = UIDesign.Fonts.label
        self.airportNameLabel.textColor = UIDesign.Colors.label
        self.addSubview(self.airportNameLabel)

        self.airportNameText.translatesAutoresizingMaskIntoConstraints = false
        self.airportNameText.font = UIDesign.Fonts.value
        self.airportNameText.textColor = UIDesign.Colors.value
        self.airportNameText.numberOfLines = 0
        self.addSubview(self.airportNameText)

        NSLayoutConstraint.activate([
            self.airportNameLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            self.airportNameLabel.widthAnchor.constraint(equalToConstant: 100),
            self.airportNameLabel.topAnchor.constraint(equalTo: self.airportIdLabel.bottomAnchor, constant: 8),
            self.airportNameLabel.heightAnchor.constraint(equalToConstant: 25),
            self.airportNameText.leadingAnchor.constraint(equalTo: self.airportNameLabel.trailingAnchor, constant: 8),
            self.airportNameText.topAnchor.constraint(equalTo: self.airportNameLabel.topAnchor),
            self.airportNameText.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            self.airportNameText.heightAnchor.constraint(greaterThanOrEqualToConstant: 25)
        ])
    }

    private func setupCityRow() {
        self.airportCityLabel.translatesAutoresizingMaskIntoConstraints = false
        self.airportCityLabel.font = UIDesign.Fonts.label
        self.airportCityLabel.textColor = UIDesign.Colors.label
        self.addSubview(self.airportCityLabel)

        self.airportCityText.translatesAutoresizingMaskIntoConstraints = false
        self.airportCityText.font = UIDesign.Fonts.value
        self.airportCityText.textColor = UIDesign.Colors.value
        self.addSubview(self.airportCityText)

        NSLayoutConstraint.activate([
            self.airportCityLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            self.airportCityLabel.widthAnchor.constraint(equalToConstant: 100),
            self.airportCityLabel.topAnchor.constraint(equalTo: self.airportNameText.bottomAnchor, constant: 8),
            self.airportCityLabel.heightAnchor.constraint(equalToConstant: 25),
            self.airportCityText.leadingAnchor.constraint(equalTo: self.airportCityLabel.trailingAnchor, constant: 8),
            self.airportCityText.topAnchor.constraint(equalTo: self.airportCityLabel.topAnchor),
            self.airportCityText.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            self.airportCityText.heightAnchor.constraint(equalTo: self.airportCityLabel.heightAnchor)
        ])
    }

    private func setupCountryRow() {
        self.airportCountryLabel.translatesAutoresizingMaskIntoConstraints = false
        self.airportCountryLabel.font = UIDesign.Fonts.label
        self.airportCountryLabel.textColor = UIDesign.Colors.label
        self.addSubview(self.airportCountryLabel)

        self.airportCountryText.translatesAutoresizingMaskIntoConstraints = false
        self.airportCountryText.font = UIDesign.Fonts.value
        self.airportCountryText.textColor = UIDesign.Colors.value
        self.addSubview(self.airportCountryText)

        NSLayoutConstraint.activate([
            self.airportCountryLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            self.airportCountryLabel.widthAnchor.constraint(equalToConstant: 100),
            self.airportCountryLabel.topAnchor.constraint(equalTo: self.airportCityLabel.bottomAnchor, constant: 8),
            self.airportCountryLabel.heightAnchor.constraint(equalToConstant: 25),
            self.airportCountryText.leadingAnchor.constraint(equalTo: self.airportCountryLabel.trailingAnchor, constant: 8),
            self.airportCountryText.topAnchor.constraint(equalTo: self.airportCountryLabel.topAnchor),
            self.airportCountryText.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            self.airportCountryText.heightAnchor.constraint(equalTo: self.airportIdLabel.heightAnchor)
        ])
    }

    private func setupLatitudeRow() {
        self.airportLatitudeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.airportLatitudeLabel.font = UIDesign.Fonts.label
        self.airportLatitudeLabel.textColor = UIDesign.Colors.label
        self.addSubview(self.airportLatitudeLabel)

        self.airportLatitudeText.translatesAutoresizingMaskIntoConstraints = false
        self.airportLatitudeText.font = UIDesign.Fonts.value
        self.airportLatitudeText.textColor = UIDesign.Colors.value
        self.addSubview(self.airportLatitudeText)

        NSLayoutConstraint.activate([
            self.airportLatitudeLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            self.airportLatitudeLabel.widthAnchor.constraint(equalToConstant: 100),
            self.airportLatitudeLabel.topAnchor.constraint(equalTo: self.airportCountryLabel.bottomAnchor, constant: 8),
            self.airportLatitudeLabel.heightAnchor.constraint(equalToConstant: 25),
            self.airportLatitudeText.leadingAnchor.constraint(equalTo: self.airportLatitudeLabel.trailingAnchor, constant: 8),
            self.airportLatitudeText.topAnchor.constraint(equalTo: self.airportLatitudeLabel.topAnchor),
            self.airportLatitudeText.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            self.airportLatitudeText.heightAnchor.constraint(equalTo: self.airportLatitudeLabel.heightAnchor)
        ])
    }

    private func setupLongitudeRow() {
        self.airportLongitudeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.airportLongitudeLabel.font = UIDesign.Fonts.label
        self.airportLongitudeLabel.textColor = UIDesign.Colors.label
        self.addSubview(self.airportLongitudeLabel)

        self.airportLongitudeText.translatesAutoresizingMaskIntoConstraints = false
        self.airportLongitudeText.font = UIDesign.Fonts.value
        self.airportLongitudeText.textColor = UIDesign.Colors.value
        self.addSubview(self.airportLongitudeText)

        NSLayoutConstraint.activate([
            self.airportLongitudeLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            self.airportLongitudeLabel.widthAnchor.constraint(equalToConstant: 100),
            self.airportLongitudeLabel.topAnchor.constraint(equalTo: self.airportLatitudeLabel.bottomAnchor, constant: 8),
            self.airportLongitudeLabel.heightAnchor.constraint(equalToConstant: 25),
            self.airportLongitudeText.leadingAnchor.constraint(equalTo: self.airportLongitudeLabel.trailingAnchor, constant: 8),
            self.airportLongitudeText.topAnchor.constraint(equalTo: self.airportLongitudeLabel.topAnchor),
            self.airportLongitudeText.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            self.airportLongitudeText.heightAnchor.constraint(equalTo: self.airportLongitudeLabel.heightAnchor)
        ])
    }

    private func setupClosestAirportTitle() {
        self.closestAirportTitle.translatesAutoresizingMaskIntoConstraints = false
        self.closestAirportTitle.font = UIDesign.Fonts.label
        self.closestAirportTitle.textColor = UIDesign.Colors.label
        self.closestAirportTitle.textAlignment = .center
        self.addSubview(self.closestAirportTitle)

        NSLayoutConstraint.activate([
            self.closestAirportTitle.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            self.closestAirportTitle.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant:  -8),
            self.closestAirportTitle.topAnchor.constraint(equalTo: self.airportLongitudeLabel.bottomAnchor, constant: 16),
            self.closestAirportTitle.heightAnchor.constraint(equalToConstant: 25)
        ])
    }

    private func setupClosestAirportRow() {
        self.closestAirportNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.closestAirportNameLabel.font = UIDesign.Fonts.label
        self.closestAirportNameLabel.textColor = UIDesign.Colors.label
        self.closestAirportNameLabel.numberOfLines = 0
        self.addSubview(self.closestAirportNameLabel)

        self.closestAirportNameText.translatesAutoresizingMaskIntoConstraints = false
        self.closestAirportNameText.font = UIDesign.Fonts.value
        self.closestAirportNameText.textColor = UIDesign.Colors.value
        self.addSubview(self.closestAirportNameText)

        NSLayoutConstraint.activate([
            self.closestAirportNameLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            self.closestAirportNameLabel.widthAnchor.constraint(equalToConstant: 100),
            self.closestAirportNameLabel.topAnchor.constraint(equalTo: self.closestAirportTitle.bottomAnchor, constant: 16),
            self.closestAirportNameLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 25),
            self.closestAirportNameText.leadingAnchor.constraint(equalTo: self.closestAirportNameLabel.trailingAnchor, constant: 8),
            self.closestAirportNameText.topAnchor.constraint(equalTo: self.closestAirportNameLabel.topAnchor),
            self.closestAirportNameText.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            self.closestAirportNameText.heightAnchor.constraint(equalTo: self.closestAirportNameLabel.heightAnchor)
        ])
    }

    private func setupAirportDistanceRow() {
        self.airportDistanceLabel.translatesAutoresizingMaskIntoConstraints = false
        self.airportDistanceLabel.font = UIDesign.Fonts.label
        self.airportDistanceLabel.textColor = UIDesign.Colors.label
        self.addSubview(self.airportDistanceLabel)

        self.airportDistanceText.translatesAutoresizingMaskIntoConstraints = false
        self.airportDistanceText.font = UIDesign.Fonts.value
        self.airportDistanceText.textColor = UIDesign.Colors.value
        self.addSubview(self.airportDistanceText)

        NSLayoutConstraint.activate([
            self.airportDistanceLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            self.airportDistanceLabel.widthAnchor.constraint(equalToConstant: 100),
            self.airportDistanceLabel.topAnchor.constraint(equalTo: self.closestAirportNameLabel.bottomAnchor, constant: 8),
            self.airportDistanceLabel.heightAnchor.constraint(equalToConstant: 25),
            self.airportDistanceText.leadingAnchor.constraint(equalTo: self.airportDistanceLabel.trailingAnchor, constant: 8),
            self.airportDistanceText.topAnchor.constraint(equalTo: self.airportDistanceLabel.topAnchor),
            self.airportDistanceText.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            self.airportDistanceText.heightAnchor.constraint(equalTo: self.airportDistanceLabel.heightAnchor)
        ])
    }
}
