//
//  WeatherListCoordinator.swift
//  WeatherLook_iOS
//
//  Created by 전소영 on 2022/03/07.
//

import Foundation
import UIKit

class WeatherListCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    weak var parentCoordinator: Coordinator?
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() { }
    
    func start(completion: ((Int) -> Void)? = nil) {
        let weatherListViewController = WeatherListViewController()
        weatherListViewController.completion = completion
        weatherListViewController.viewModel = WeatherListViewModel(coordinator: self, weatherUseCase: WeatherUseCase(weatherRepository: DefaultWeatherRepository()))
        navigationController.pushViewController(weatherListViewController, animated: false)
    }
    
    func popWeatherListViewController() {
        navigationController.popViewController(animated: true)
    }
    
    func pushSearchViewController() {
        let searchCoordinator = SearchCoordinator(navigationController)
        searchCoordinator.parentCoordinator = self
        self.childCoordinators.append(searchCoordinator)
        
        searchCoordinator.start()
    }
}
