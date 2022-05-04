//
//  SplashCoordinator.swift
//  WeatherLook_iOS
//
//  Created by 전소영 on 2022/02/04.
//

import Foundation
import UIKit

class SplashCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    weak var parentCoordinator: Coordinator?
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let splashViewController = SplashViewController()
        splashViewController.viewModel = SplashViewModel(coordinator: self)
        navigationController.pushViewController(splashViewController, animated: false)
    }
    
    func pushWeatherPageViewController() {
        let weatherPageCoordinator = WeatherPageCoordinator(navigationController)
        weatherPageCoordinator.parentCoordinator = self
        self.childCoordinators.append(weatherPageCoordinator)
        
        weatherPageCoordinator.start()
    }
}
