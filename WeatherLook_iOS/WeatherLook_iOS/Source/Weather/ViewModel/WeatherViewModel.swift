//
//  WeatherViewModel.swift
//  WeatherLook_iOS
//
//  Created by 전소영 on 2022/02/16.
//

import Foundation

import RxSwift

class WeatherViewModel: ViewModelType {
    private var location: Location?
    var weatherData: WeatherData?
    var disposeBag = DisposeBag()
    
    struct Action {
        let fetch = PublishSubject<Location>()
    }
    
    struct State {
        let weatherDataResponse = PublishSubject<WeatherData>()
    }
    
    var action = Action()
    var state = State()
    
    init() {
        configure()
    }
    
    private func configure() {
        action.fetch
            .subscribe(onNext: { location in
                self.location = location
                self.requestWeatherData()
            }).disposed(by: self.disposeBag)
    }
    
    private func requestWeatherData() {
        guard let latitude = location?.coordinate.latitude,
              let longitude = location?.coordinate.longitude else {
                  return
              }
        
        APIService.shared.request(WeatherAPI.getWeatherData(latitude: latitude, longitude: longitude))
            .subscribe(onSuccess: { [weak self] (weatherData: WeatherData) in
                guard let self = self else { return }
                self.weatherData = weatherData
                self.state.weatherDataResponse.onNext(weatherData)
            }).disposed(by: self.disposeBag)
    }
}
