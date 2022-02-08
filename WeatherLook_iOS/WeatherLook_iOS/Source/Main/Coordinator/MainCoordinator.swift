//
//  MainCoordinator.swift
//  WeatherLook_iOS
//
//  Created by 전소영 on 2022/02/04.
//

import UIKit

class MainCoordinator: NSObject, Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
   
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.setNavigationBarHidden(true, animated: true)
    }
    
    func start() {
        let splashCoordinator = SplashCoordinator(navigationController)
        splashCoordinator.parentCoordinator = self
        self.childCoordinators.append(splashCoordinator)
        
        splashCoordinator.start()
    }
}
