//
//  WeatherCoordinator.swift
//  WeatherLook_iOS
//
//  Created by 전소영 on 2022/02/08.
//

import Foundation
import UIKit

class WeatherCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    weak var parentCoordinator: Coordinator?
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let weatherPageViewController = WeatherPageViewController()
        weatherPageViewController.coordinator = self
        navigationController.pushViewController(weatherPageViewController, animated: false)
    }
    
    func pushWeatherListViewController() {
        let weatherListCoordinator = WeatherListCoordinator(navigationController)
        weatherListCoordinator.parentCoordinator = self
        self.childCoordinators.append(weatherListCoordinator)
        
        weatherListCoordinator.start()
    }
}
