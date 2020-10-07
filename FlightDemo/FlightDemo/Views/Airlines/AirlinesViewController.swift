//
//  AlbumsView.swift
//  PhotoAlbum
//
//  Created by Gábor Vass on 26/09/2020.
//  Copyright © 2020 Gábor Vass. All rights reserved.
//

import Foundation
import UIKit

class AirlinesViewController: UIViewController {
    
    private let model: AirlinesViewModel
    
    required init(_ model: AirlinesViewModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        self.setupTabBarItem()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var content: GenericTableViewController<AirlineView, GenericTableViewCell<AirlineView>> = {
        let tableVC = GenericTableViewController<AirlineView, GenericTableViewCell<AirlineView>>()
        tableVC.configureCell = { [weak self] indexPath, cell in
            guard let entry = self?.model.airlineDistances[indexPath.row] else {
                return
            }
            cell.view.updateContent(entry.key, distance: entry.value)
        }
        tableVC.heightForRow = { _ in
            return 60
        }
        tableVC.numberOfItems = { [weak self] in
            return self?.model.airlineDistances.count ?? 0
        }
        tableVC.tableView.estimatedRowHeight = 100
        return tableVC
    }()

    private lazy var stateManager: ViewStateManager = {
        return ViewStateManager(parent: self)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupModel()
        self.install(self.content)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.model.load()
    }
    
    private func setupTabBarItem() {
        let tabBarItem = UITabBarItem.init(
            title: NSLocalizedString("Airlines",
                                     comment: "Airlines View Title"),
            image: UIImage.init(named: "aircraft_icon"),
            selectedImage: nil)
        self.tabBarItem = tabBarItem
    }

    private func setupModel() {
        self.model.onAirlinesSorted = { [weak self] in
            self?.stateManager.state = .hideLoading
            self?.content.tableView.reloadData()
        }
        self.model.onError = { [weak self] error in
            self?.stateManager.state = .showError(error)
        }
    }
    

}
