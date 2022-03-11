//
//  SearchCoordinator.swift
//  WeatherLook_iOS
//
//  Created by 전소영 on 2022/03/10.
//

import Foundation
import UIKit

class SearchCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    weak var parentCoordinator: Coordinator?
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let searchViewController = SearchViewController()
        searchViewController.coordinator = self
        navigationController.topViewController?.present(searchViewController, animated: true, completion: nil)
    }
    
    func dismiss() {
        navigationController.dismiss(animated: true, completion: nil)
    }
    
    func presentWeatherViewController(with location: Location) {
        let weatherViewController = WeatherViewController()
        weatherViewController.location = location
        weatherViewController.pageCase = "search"
        navigationController.topViewController?.presentedViewController?.present(weatherViewController, animated: false, completion: nil)
    }
}
