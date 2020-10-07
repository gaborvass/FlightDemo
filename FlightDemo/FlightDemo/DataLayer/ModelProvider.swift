//
//  DataProvider.swift
//  FlightDemo
//
//  Created by Gábor Vass on 03/10/2020.
//  Copyright © 2020 Gábor Vass. All rights reserved.
//

import Foundation

class ModelProvider<T: Decodable> {
    
    private let remoteURL: URL
    private let dataProvider: DataProvider
    private let dataConverter = DataConverter<T>()

    required init(_ url: String, dataProvider: DataProvider) {
        self.remoteURL = URL.init(string: url)!
        self.dataProvider = dataProvider
    }
    
    func provide(_ then: @escaping (Result<T, FlightDemoError>) -> Void) {
        dataProvider.fetch(self.remoteURL) { result in
            switch result {
            case .success(let data):
                self.executeOnMain {
                    then(self.dataConverter.convert(data))
                }
            case .failure(let failure):
                self.executeOnMain {
                    then(.failure(failure))
                }
            }
        }
    }

    private func executeOnMain(_ function: @escaping () -> Void) {
        DispatchQueue.main.async {
            function()
        }
    }
}
