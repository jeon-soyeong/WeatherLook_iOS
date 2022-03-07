//
//  WeatherViewModel.swift
//  WeatherLook_iOS
//
//  Created by 전소영 on 2022/02/16.
//

import Foundation

import RxSwift
import RxCocoa

class WeatherViewModel: ViewModelType {
    private var location: Location?
    var weatherData: WeatherData?
    var disposeBag = DisposeBag()
    
    init(location: Location) {
        self.location = location
    }
    
    struct Input {}
    
    struct Output {
        let weatherDataResponse = PublishSubject<WeatherData>()
    }
    
    func transform(input: Input) -> Output {
       
        return Output()
    }
    
    private func requestWeatherData() {
        //TODO: API 연결
    }
}
