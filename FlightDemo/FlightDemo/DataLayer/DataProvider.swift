//
//  DataProvider.swift
//  FlightDemo
//
//  Created by Gábor Vass on 03/10/2020.
//  Copyright © 2020 Gábor Vass. All rights reserved.
//

import Foundation

protocol DataProvider {
    func fetch(_ from: URL, then handler: @escaping (Result<Data, FlightDemoError>) -> Void)
}
