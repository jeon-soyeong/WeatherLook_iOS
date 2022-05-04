//
//  WeatherRepository.swift
//  WeatherLook_iOS
//
//  Created by 전소영 on 2022/05/03.
//

import Foundation

import RxSwift

protocol WeatherRepository {
    func fetchWeatherData(latitude: Double, longitude: Double) -> Single<WeatherData>
}
