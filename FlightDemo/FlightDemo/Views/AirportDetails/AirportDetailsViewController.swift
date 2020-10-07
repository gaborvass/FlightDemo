//
//  AirportDetailsViewController.swift
//  FlightDemo
//
//  Created by Gábor Vass on 03/10/2020.
//  Copyright © 2020 Gábor Vass. All rights reserved.
//

import Foundation
import UIKit

class AirportDetailsViewController: UIViewController {

    var selectedAirport: Airport? {
        didSet {
            self.stateManager.state = .showLoading
            self.model.selectedAirport = selectedAirport
            self.model.loadAirportDetails()
        }
    }

    private let model: AirportDetailsViewModel

    required init(_ model: AirportDetailsViewModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var detailsView: AirportDetailsView = {
        return AirportDetailsView()
    }()

    private lazy var stateManager: ViewStateManager = {
        return ViewStateManager(parent: self)
    }()

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        super.viewWillAppear(animated)
        if let airport = self.selectedAirport {
            self.detailsView.updateContent(airport)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupModel()
        setupView()
    }

    private func showClosestAirport(_ airport: Airport, distance: Double) {
        self.detailsView.updateClosestAirport(airport, distance: distance)
    }

    private func setupModel() {
        self.model.closestAirportFound = { (airport, distance) in
            self.showClosestAirport(airport, distance: distance)
            self.stateManager.state = .hideLoading
        }
        self.model.onError = { error in
            self.stateManager.state = .showError(error)
        }
    }

    private func setupView() {
        self.view.backgroundColor = UIDesign.Colors.viewBackground
        self.view.addSubview(self.detailsView)
        NSLayoutConstraint.activate([
            self.detailsView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.detailsView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.detailsView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.detailsView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
