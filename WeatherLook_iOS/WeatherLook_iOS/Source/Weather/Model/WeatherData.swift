//
//  WeatherData.swift
//  WeatherLook_iOS
//
//  Created by 전소영 on 2022/02/16.
//

import Foundation

struct WeatherData: Codable {
    let current: Current
    let hourly: [Hourly]
    let daily: [Daily]
}

struct Current: Codable {
    let dt: Int
    let temp: Float
    let weather: [CurrentWeather]
}

struct CurrentWeather: Codable {
    let main: String
}

struct Hourly: Codable {
    let dt: Int
    let temp: Float
    let weather: [HourlyWeather]
}

struct HourlyWeather: Codable {
    let main: String
}

struct Daily: Codable {
    let dt: Int
    let temp: DailyTemperature
    let weather: [DailyWeather]
    let pop: Float
}

struct DailyTemperature: Codable {
    let min: Float
    let max: Float
}

struct DailyWeather: Codable {
    let main: String
}
