//
//  PreViewCoordinator.swift
//  WeatherLook_iOS
//
//  Created by 전소영 on 2022/06/07.
//

import Foundation
import UIKit

class PreViewCoordinator: NSObject, Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    weak var parentCoordinator: Coordinator?
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let previewViewController = PreviewViewController()
        previewViewController.coordinator = self
        navigationController.pushViewController(previewViewController, animated: false)
    }
}
