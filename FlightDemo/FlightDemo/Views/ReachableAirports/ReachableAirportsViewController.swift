//
//  AvailableAirportsView.swift
//  FlightDemo
//
//  Created by Gábor Vass on 05/10/2020.
//  Copyright © 2020 Gábor Vass. All rights reserved.
//

import Foundation
import UIKit

class ReachableAirportsView: UIViewController {
    
    private let model: ReachableAirportsViewModel

    required init(_ model: ReachableAirportsViewModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        self.setupTabBarItem()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupModel()
        self.install(self.content)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.stateManager.state = .showLoading
        self.model.load()
    }

    private lazy var content: GenericTableViewController<AirportView, GenericTableViewCell<AirportView>> = {
        let tableVC = GenericTableViewController<AirportView, GenericTableViewCell<AirportView>>()
        tableVC.configureCell = { [weak self] indexPath, cell in
            guard let airport = self?.model.reachableAirports[indexPath.row] else {
                return
            }
            cell.view.updateContent(airport)
        }
        tableVC.heightForRow = { _ in
            return 60
        }
        tableVC.numberOfItems = { [weak self] in
            return self?.model.reachableAirports.count ?? 0
        }
        tableVC.tableView.estimatedRowHeight = 100
        return tableVC

    }()

    private lazy var stateManager: ViewStateManager = {
        return ViewStateManager(parent: self)
    }()

    private func setupTabBarItem() {
        let tabBarItem = UITabBarItem.init(
            title: NSLocalizedString("Destinations",
                                     comment: "Destinations View Title"),
            image: UIImage.init(named: "destination_icon"),
            selectedImage: nil)
        self.tabBarItem = tabBarItem
    }

    private func setupModel() {
        self.model.onAirportsSorted = { [weak self] in
            self?.content.tableView.reloadData()
            self?.stateManager.state = .hideLoading
        }
        self.model.onError = { [weak self] error in
            self?.stateManager.state = .showError(error)
        }
    }
}
