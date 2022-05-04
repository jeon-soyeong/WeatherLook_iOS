//
//  WeatherPageViewModel.swift
//  WeatherLook_iOS
//
//  Created by 전소영 on 2022/05/03.
//

import Foundation

import RxSwift

class WeatherPageViewModel: ViewModelType {
    weak var coordinator: WeatherPageCoordinator?
    var disposeBag = DisposeBag()
    
    struct Action {}
    struct State {}
    
    init(coordinator: WeatherPageCoordinator?) {
        self.coordinator = coordinator
    }
    
    func pushWeatherListViewController(completion: ((Int) -> Void)? = nil) {
        coordinator?.pushWeatherListViewController(completion: completion)
    }
}
