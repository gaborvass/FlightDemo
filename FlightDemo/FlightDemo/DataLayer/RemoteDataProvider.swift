//
//  RemoteDataProvider.swift
//  FlightDemo
//
//  Created by Gábor Vass on 05/10/2020.
//  Copyright © 2020 Gábor Vass. All rights reserved.
//

import Foundation

class RemoteDataProvider: DataProvider {
    func fetch(_ from: URL, then handler: @escaping (Result<Data, FlightDemoError>) -> Void) {
        DispatchQueue.global().async {
            let task = URLSession.shared.dataTask(with: from) { (data, response, _) in
                guard let rawResult = data,
                    let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                        return handler(.failure(.networkError))
                }
                handler(.success(rawResult))
            }
            task.resume()
        }
    }
}
