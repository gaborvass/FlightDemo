//
//  SettingsViewController.swift
//  FlightDemo
//
//  Created by Gábor Vass on 06/10/2020.
//  Copyright © 2020 Gábor Vass. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController {

    required init() {
        super.init(nibName: nil, bundle: nil)
        self.setupTabBarItem()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var model: SettingsViewModel = {
        return SettingsViewModel()
    }()

    lazy var content: GenericTableViewController<ChooseSettingView, GenericTableViewCell<ChooseSettingView>> = {
        let tableVC = GenericTableViewController<ChooseSettingView, GenericTableViewCell<ChooseSettingView>>()
        tableVC.configureCell = { [weak self] indexPath, cell in
            if let currentValue = self?.model.currentValue() {
                cell.view.updateContent(currentValue: currentValue)
            }
            cell.view.onValueChanged = { newValue in
                self?.model.updateValue(UnitsOfMeasure.init(rawValue: newValue)!)
            }
        }
        tableVC.heightForRow = { _ in
            return 60
        }
        tableVC.numberOfItems = {
            return 1
        }
        tableVC.tableView.separatorStyle = .none
        return tableVC
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.install(self.content)
    }
    
    private func setupTabBarItem() {
        let tabBarItem = UITabBarItem.init(
            title: NSLocalizedString("Settings",
            comment: "Settings View Title"),
            image: UIImage.init(named: "settings_icon"),
            selectedImage: nil)
        self.tabBarItem = tabBarItem
    }
}
