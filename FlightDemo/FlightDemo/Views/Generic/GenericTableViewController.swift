//
//  GenericTableViewController.swift
//  FlightDemo
//
//  Created by Gábor Vass on 03/10/2020.
//  Copyright © 2020 Gábor Vass. All rights reserved.
//

import Foundation
import UIKit

class GenericTableViewController<View: UIView, Cell: GenericTableViewCell<View>>: UITableViewController {
    
    // Closure to provide number of items
    var numberOfItems: () -> Int = {0} {
        didSet {
            tableView.reloadData()
        }
    }

    // Closure to configure cell
    var configureCell: ((IndexPath, Cell) -> Void)?

    // Closure to configure row height
    var heightForRow: ((IndexPath) -> CGFloat)?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.register(Cell.self, forCellReuseIdentifier: "cell")
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForRow?(indexPath) ?? 44.0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfItems()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? Cell else {
            return UITableViewCell()
        }
        configureCell?(indexPath, cell)
        return cell
    }
}
