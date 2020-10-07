//
//  UIViewControllerExtension.swift
//  FlightDemo
//
//  Created by Gábor Vass on 06/10/2020.
//  Copyright © 2020 Gábor Vass. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func install(_ child: UIViewController, inside: UIView? = nil) {
        addChild(child)
        child.view.translatesAutoresizingMaskIntoConstraints = false
        guard let viewEmbedInto = inside == nil ? self.view : inside else {
            return
        }
        viewEmbedInto.addSubview(child.view)
        NSLayoutConstraint.activate([
            child.view.leadingAnchor.constraint(equalTo: viewEmbedInto.safeAreaLayoutGuide.leadingAnchor),
            child.view.trailingAnchor.constraint(equalTo: viewEmbedInto.safeAreaLayoutGuide.trailingAnchor),
            child.view.topAnchor.constraint(equalTo: viewEmbedInto.safeAreaLayoutGuide.topAnchor),
            child.view.bottomAnchor.constraint(equalTo: viewEmbedInto.safeAreaLayoutGuide.bottomAnchor)
        ])
        child.didMove(toParent: self)
    }
}
