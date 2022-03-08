//
//  WeatherCoordinator.swift
//  WeatherLook_iOS
//
//  Created by 전소영 on 2022/02/08.
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
    
    func start() {
        navigationController.delegate = self
        
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
    
    func removeChildCoordinator(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}

extension WeatherCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }
        
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
        
        if let weatherListViewController = fromViewController as? WeatherListViewController {
            removeChildCoordinator(weatherListViewController.coordinator)
        }
    }
}
