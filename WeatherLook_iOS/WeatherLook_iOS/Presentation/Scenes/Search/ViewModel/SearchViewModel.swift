//
//  SearchViewModel.swift
//  WeatherLook_iOS
//
//  Created by 전소영 on 2022/05/03.
//

import Foundation

import RxSwift

class SearchViewModel: ViewModelType {
    weak var coordinator: SearchCoordinator?
    var disposeBag = DisposeBag()
    
    struct Action {}
    struct State {}
    
    init(coordinator: SearchCoordinator?) {
        self.coordinator = coordinator
    }
    
    func dismiss() {
        coordinator?.dismiss()
    }
    
    func presentWeatherViewController(with location: Location) {
        coordinator?.presentWeatherViewController(with: location)
    }
}
