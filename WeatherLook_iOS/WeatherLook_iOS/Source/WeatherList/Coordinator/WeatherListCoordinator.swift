//
//  WeatherListCoordinator.swift
//  WeatherLook_iOS
//
//  Created by 전소영 on 2022/03/07.
//

import UIKit

class WeatherListCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    weak var parentCoordinator: Coordinator?
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let weatherListViewController = WeatherListViewController()
        weatherListViewController.coordinator = self
        navigationController.pushViewController(weatherListViewController, animated: false)
    }
    
    func popWeatherListViewController() {
        navigationController.popViewController(animated: true)
    }
}
