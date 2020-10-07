//
//  UIAlertViewControllerExtension.swift
//  FlightDemo
//
//  Created by Gábor Vass on 06/10/2020.
//  Copyright © 2020 Gábor Vass. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {
    
    class func show(title: String?, message: String?) {
        let alertController = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let closeAction = UIAlertAction.init(title: NSLocalizedString("OK", comment: "OK button in alert"), style: .default, handler: { _ in
            alertController.dismiss(animated: false, completion: nil)
        })
        alertController.addAction(closeAction)
        alertController.view.accessibilityViewIsModal = true
        var presentedViewController = UIApplication.shared.keyWindow?.rootViewController
        if presentedViewController?.presentedViewController != nil {
            presentedViewController = presentedViewController?.presentedViewController
        }
        presentedViewController?.present(alertController, animated: false, completion: nil)
    }
}
