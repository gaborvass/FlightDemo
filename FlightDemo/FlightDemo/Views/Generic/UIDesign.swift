//
//  UIDesign.swift
//  FlightDemo
//
//  Created by Gábor Vass on 06/10/2020.
//  Copyright © 2020 Gábor Vass. All rights reserved.
//

import Foundation
import UIKit

enum UIDesign {
    enum Colors {
        
        // label color
        static let label: UIColor = {
            if #available(iOS 13.0, *) {
                return UIColor.label
            }
            return UIColor.black
        }()

        // text value color
        static let value: UIColor = {
            if #available(iOS 13.0, *) {
                return UIColor.secondaryLabel
            }
            return UIColor.darkGray
        }()
        
        // view background color
        static let viewBackground: UIColor = {
            if #available(iOS 13.0, *) {
                return UIColor.systemBackground
            }
            return UIColor.white
        }()
        
        // loading indicator color
        static let loadingIndicator: UIColor = {
            if #available(iOS 13.0, *) {
                return UIColor.systemGray
            }
            return UIColor.gray
        }()
    }

    enum Fonts {
        
        // style for label
        static let label: UIFont = {
            UIFont.boldSystemFont(ofSize: 16)
        }()

        // style for text value
        static let value: UIFont = {
            UIFont.systemFont(ofSize: 16)
        }()
    }
}
