//
//  LoadingView.swift
//  FlightDemo
//
//  Created by Gábor Vass on 03/10/2020.
//  Copyright © 2020 Gábor Vass. All rights reserved.
//

import Foundation
import UIKit

class LoadingViewController: UIViewController {

    private var loadingIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.loadingIndicator.startAnimating()
        super.viewDidAppear(animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        self.loadingIndicator.stopAnimating()
        super.viewDidDisappear(animated)
    }
    
    private func setup() {
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.backgroundColor = .gray
        self.view.alpha = 0.4
        setupLoadingIndicator()
    }

    private func setupLoadingIndicator() {
        self.loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.loadingIndicator.style = .whiteLarge
        self.view.addSubview(self.loadingIndicator)
        NSLayoutConstraint.activate([
            self.loadingIndicator.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            self.loadingIndicator.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
}
