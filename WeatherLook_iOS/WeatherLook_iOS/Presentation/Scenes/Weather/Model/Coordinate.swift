//
//  Coordinate.swift
//  WeatherLook_iOS
//
//  Created by 전소영 on 2022/03/02.
//

import Foundation

struct Coordinate: Codable {
    let latitude: Double
    let longitude: Double
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
