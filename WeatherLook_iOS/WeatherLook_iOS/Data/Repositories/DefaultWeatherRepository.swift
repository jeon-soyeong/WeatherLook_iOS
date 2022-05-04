//
//  DefaultWeatherRepository.swift
//  WeatherLook_iOS
//
//  Created by 전소영 on 2022/05/03.
//

import Foundation

import RxSwift

class DefaultWeatherRepository: WeatherRepository {
    func fetchWeatherData(latitude: Double, longitude: Double) -> Single<WeatherData> {
        return APIService.shared.request(WeatherAPI.getWeatherData(latitude: latitude, longitude: longitude), WeatherDataResponseDTO.self)
            .map{ $0.toDomain() }
    }
}
