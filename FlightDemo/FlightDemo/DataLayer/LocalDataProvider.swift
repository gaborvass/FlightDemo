//
//  LocalDataProvider.swift
//  FlightDemo
//
//  Created by Gábor Vass on 03/10/2020.
//  Copyright © 2020 Gábor Vass. All rights reserved.
//

import Foundation

// provides data from json files
class LocalDataProvider: DataProvider {

    // used for test for determine which bundle to use
    private let isTest: Bool

    required init(test: Bool = false) {
        isTest = test
    }

    func fetch(_ from: URL, then handler: @escaping (Result<Data, FlightDemoError>) -> Void) {
        handler(.success(read(from.deletingPathExtension().lastPathComponent)))
    }

    private func read(_ file: String) -> Data {
        let bundle = isTest ? Bundle(for: LocalDataProvider.self) : Bundle.main
        guard let path = bundle.path(forResource: file, ofType: "json") else {
            fatalError("incorrect bundle")
        }
        guard let data = try? Data.init(contentsOf: URL.init(fileURLWithPath: path)) else {
            fatalError("incorrect bundle")
        }
        return data
    }
}
