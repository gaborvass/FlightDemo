//
//  DataConverter.swift
//  FlightDemo
//
//  Created by Gábor Vass on 03/10/2020.
//  Copyright © 2020 Gábor Vass. All rights reserved.
//

import Foundation

class DataConverter<T> where T: Decodable {
    func convert(_ data: Data) -> Result<T, FlightDemoError> {
        if let result = try? JSONDecoder().decode(T.self, from: data) {
            return .success(result)
        }
        return .failure(.parserError)
    }
}
