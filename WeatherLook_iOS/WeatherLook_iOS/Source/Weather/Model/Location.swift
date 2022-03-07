//
//  Location.swift
//  WeatherLook_iOS
//
//  Created by 전소영 on 2022/03/02.
//

import Foundation

struct Location: Equatable, Codable {
    var coordinate: Coordinate
    let name: String
    
    init(coordinate: Coordinate, name: String) {
        self.coordinate = coordinate
        self.name = name
    }
    
    static func == (lhs: Location, rhs: Location) -> Bool {
        return lhs.name == rhs.name
    }
}
