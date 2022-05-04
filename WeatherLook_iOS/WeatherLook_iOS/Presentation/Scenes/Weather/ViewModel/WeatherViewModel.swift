//
//  WeatherViewModel.swift
//  WeatherLook_iOS
//
//  Created by 전소영 on 2022/02/16.
//

import Foundation

import RxSwift

class WeatherViewModel: ViewModelType {
    weak var coordinator: WeatherCoordinator?
    private let weatherUseCase: WeatherUseCase
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
    
    init(coordinator: WeatherCoordinator?, weatherUseCase: WeatherUseCase) {
        self.coordinator = coordinator
        self.weatherUseCase = weatherUseCase
        configure()
    }
    
    private func configure() {
        action.fetch
            .subscribe(onNext: { location in
                self.location = location
                self.requestWeatherData()
            })
            .disposed(by: disposeBag)
    }
    
    private func requestWeatherData() {
        guard let latitude = location?.coordinate.latitude,
              let longitude = location?.coordinate.longitude else {
                  return
              }
        
        weatherUseCase.execute(latitude: latitude, longitude: longitude)
            .subscribe(onSuccess: { [weak self] (weatherData: WeatherData) in
                guard let self = self else { return }
                self.weatherData = weatherData
                self.state.weatherDataResponse.onNext(weatherData)
            })
            .disposed(by: self.disposeBag)
    }
    
    func popToWeatherListController() {
        coordinator?.popToWeatherListController()
    }
    
    func popWeatherViewController() {
        coordinator?.popWeatherViewController()
    }
}
