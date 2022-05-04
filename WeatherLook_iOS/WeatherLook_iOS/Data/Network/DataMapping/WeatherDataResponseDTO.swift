//
//  WeatherDataResponseDTO.swift
//  WeatherLook_iOS
//
//  Created by 전소영 on 2022/05/04.
//

import Foundation

struct WeatherDataResponseDTO: Codable {
    let current: CurrentDTO
    let hourly: [HourlyDTO]
    let daily: [DailyDTO]
}

extension WeatherDataResponseDTO {
    struct CurrentDTO: Codable {
        let dt: Int
        let temp: Float
        let weather: [CurrentWeatherDTO]
    }
}

extension WeatherDataResponseDTO.CurrentDTO {
    struct CurrentWeatherDTO: Codable {
        let main: String
    }
}

extension WeatherDataResponseDTO {
    struct HourlyDTO: Codable {
        let dt: Int
        let temp: Float
        let weather: [HourlyWeatherDTO]
    }
}

extension WeatherDataResponseDTO.HourlyDTO {
    struct HourlyWeatherDTO: Codable {
        let main: String
    }
}

extension WeatherDataResponseDTO {
    struct DailyDTO: Codable {
        let dt: Int
        let temp: DailyTemperatureDTO
        let weather: [DailyWeatherDTO]
        let pop: Float
    }
}

extension WeatherDataResponseDTO.DailyDTO {
    struct DailyTemperatureDTO: Codable {
        let min: Float
        let max: Float
    }
}

extension WeatherDataResponseDTO.DailyDTO {
    struct DailyWeatherDTO: Codable {
        let main: String
    }
}

extension WeatherDataResponseDTO {
    func toDomain() -> WeatherData {
        return .init(current: current.toDomain(),
                     hourly: hourly.map { $0.toDomain() },
                     daily: daily.map { $0.toDomain() })
    }
}

extension WeatherDataResponseDTO.CurrentDTO {
    func toDomain() -> Current {
        return .init(dt: dt,
                     temp: temp,
                     weather: weather.map { $0.toDomain() })
    }
}

extension WeatherDataResponseDTO.CurrentDTO.CurrentWeatherDTO {
    func toDomain() -> CurrentWeather {
        return .init(main: main)
    }
}

extension WeatherDataResponseDTO.HourlyDTO {
    func toDomain() -> Hourly {
        return .init(dt: dt,
                     temp: temp,
                     weather: weather.map { $0.toDomain() })
    }
}

extension WeatherDataResponseDTO.HourlyDTO.HourlyWeatherDTO {
    func toDomain() -> HourlyWeather {
        return .init(main: main)
    }
}

extension WeatherDataResponseDTO.DailyDTO {
    func toDomain() -> Daily {
        return .init(dt: dt,
                     temp: temp.toDomain(),
                     weather: weather.map { $0.toDomain() },
                     pop: pop)
    }
}

extension WeatherDataResponseDTO.DailyDTO.DailyTemperatureDTO {
    func toDomain() -> DailyTemperature {
        return .init(min: min,
                     max: max)
    }
}

extension WeatherDataResponseDTO.DailyDTO.DailyWeatherDTO {
    func toDomain() -> DailyWeather {
        return .init(main: main)
    }
}
