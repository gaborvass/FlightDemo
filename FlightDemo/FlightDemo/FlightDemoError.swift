//
//  FlightDemoErrors.swift
//  FlightDemo
//
//  Created by Gábor Vass on 03/10/2020.
//  Copyright © 2020 Gábor Vass. All rights reserved.
//

import Foundation

enum FlightDemoError: Error {
    // Indicates network error
    case networkError
    // Indicates invalid JSON data error
    case parserError
}

extension FlightDemoError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .networkError:
            return NSLocalizedString("network_error", comment: "Network error message")
        case .parserError:
            return NSLocalizedString("parser_error", comment: "Invalid data received error")
        }
    }
}
