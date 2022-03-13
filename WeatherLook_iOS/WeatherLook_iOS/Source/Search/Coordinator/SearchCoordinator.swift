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
}
