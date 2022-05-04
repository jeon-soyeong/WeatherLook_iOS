//
//  WeatherCoordinator.swift
//  WeatherLook_iOS
//
//  Created by 전소영 on 2022/03/12.
//

import Foundation
import UIKit

class WeatherCoordinator: NSObject, Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    weak var parentCoordinator: Coordinator?
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() { }
    
    func presentWeatherViewController(location: Location) {
        let weatherViewController = WeatherViewController()
        weatherViewController.viewModel = WeatherViewModel(coordinator: self, weatherUseCase: WeatherUseCase(weatherRepository: DefaultWeatherRepository()))
        weatherViewController.location = location
        weatherViewController.pageCase = "search"
        navigationController.topViewController?.presentedViewController?.present(weatherViewController, animated: false, completion: nil)
    }
    
    func popWeatherViewController() {
        navigationController.topViewController?.presentedViewController?.presentedViewController?.dismiss(animated: true, completion: nil)
    }
    
    func popToWeatherListController() {
        navigationController.topViewController?.dismiss(animated: true, completion: nil)
    }
}
