//
//  Coordinates.swift
//  FillUpNow
//
//  Created by 한소희 on 2023/06/06.
//

import Foundation

struct GasStation: Decodable {
    let gasStations: [Coordinates]
    
    enum CodingKeys: CodingKey {
        case gasStations
    }
}

struct Coordinates: Decodable {
    let number: Int
    let name: String
    let latitude: Double
    let longitude: Double
    
    enum CodingKeys: CodingKey {
        case number, name, latitude, longitude
    }
}
