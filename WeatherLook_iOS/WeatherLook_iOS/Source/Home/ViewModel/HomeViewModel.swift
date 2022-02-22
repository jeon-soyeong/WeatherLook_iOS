//
//  HomeViewModel.swift
//  WeatherLook_iOS
//
//  Created by 전소영 on 2022/02/16.
//

import Foundation

import RxSwift
import RxCocoa

class HomeViewModel: ViewModelType {
    struct Input {
        let viewDidLoadEvent: Observable<Void>
    }
    
    struct Output {
        //TODO: API 연결 후
//        let didLoadWeatherData: Driver<Void>
    }
    
    var disposeBag = DisposeBag()
    var weatherData: WeatherData?
    
    func transform(input: Input) -> Output {
        
        return Output()
    }
}
