//
//  WeatherUseCase.swift
//  WeatherLook_iOS
//
//  Created by 전소영 on 2022/05/03.
//

import Foundation

import RxSwift

class WeatherUseCase {
    private let weatherRepository: DefaultWeatherRepository
    
    init(weatherRepository: DefaultWeatherRepository) {
        self.weatherRepository = weatherRepository
    }
    
    func execute(latitude: Double, longitude: Double) -> Single<WeatherData> {
        weatherRepository.fetchWeatherData(latitude: latitude, longitude: longitude)
    }
}
