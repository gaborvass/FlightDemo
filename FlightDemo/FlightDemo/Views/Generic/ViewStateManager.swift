//
//  ViewStateManager.swift
//  FlightDemo
//
//  Created by Gábor Vass on 06/10/2020.
//  Copyright © 2020 Gábor Vass. All rights reserved.
//

import Foundation
import UIKit

class ViewStateManager {
    
    internal enum State {
        case initial
        case showLoading
        case hideLoading
        case showError(_ error: FlightDemoError)
    }

    var state: State = .initial {
        didSet {
            self.applyState()
        }
    }

    private unowned let parentViewController: UIViewController

    private lazy var loadingView: UIViewController = {
        return LoadingViewController()
    }()

    init(parent: UIViewController) {
        self.parentViewController = parent
    }

    private func applyState() {
        switch state {
        case .initial:
            break
        case .showLoading:
            showContent(self.loadingView)
        case .hideLoading:
            hideContent(self.loadingView)
        case .showError(let error):
            hideContent(self.loadingView)
            showError(error)
        }
    }

    private func showError(_ error: FlightDemoError) {
        let title = NSLocalizedString("error", comment: "Error alert title")
        UIAlertController.show(title: title, message: error.localizedDescription)
    }

    private func hideContent(_ viewController: UIViewController) {
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
        viewController.didMove(toParent: nil)
    }

    private func showContent(_ viewController: UIViewController) {
        self.parentViewController.install(viewController)
    }

}
