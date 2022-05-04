//
//  WeatherPageCoordinator.swift
//  WeatherLook_iOS
//
//  Created by 전소영 on 2022/02/08.
//

import Foundation
import UIKit

class WeatherPageCoordinator: NSObject, Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    weak var parentCoordinator: Coordinator?
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.delegate = self
        
        let weatherPageViewController = WeatherPageViewController()
        weatherPageViewController.viewModel = WeatherPageViewModel(coordinator: self)
        navigationController.pushViewController(weatherPageViewController, animated: false)
    }
    
    func pushWeatherListViewController(completion: ((Int) -> Void)? = nil) {
        let weatherListCoordinator = WeatherListCoordinator(navigationController)
        weatherListCoordinator.parentCoordinator = self
        self.childCoordinators.append(weatherListCoordinator)
        
        weatherListCoordinator.start(completion: completion)
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

extension WeatherPageCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }
        
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
        
        if let weatherListViewController = fromViewController as? WeatherListViewController {
            removeChildCoordinator(weatherListViewController.viewModel?.coordinator)
        }
    }
}
