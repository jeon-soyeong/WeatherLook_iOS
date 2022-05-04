//
//  SplashViewModel.swift
//  WeatherLook_iOS
//
//  Created by 전소영 on 2022/05/03.
//

import Foundation

import RxSwift

class SplashViewModel: ViewModelType {
    weak var coordinator: SplashCoordinator?
    var disposeBag = DisposeBag()
    
    struct Action { }
    struct State { }
    
    init(coordinator: SplashCoordinator?) {
        self.coordinator = coordinator
    }
    
    func pushWeatherPageViewController() {
        coordinator?.pushWeatherPageViewController()
    }
}
