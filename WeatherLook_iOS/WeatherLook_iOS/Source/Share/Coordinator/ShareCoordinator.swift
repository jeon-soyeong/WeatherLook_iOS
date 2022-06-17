//
//  ShareCoordinator.swift
//  WeatherLook_iOS
//
//  Created by 전소영 on 2022/06/17.
//

import Foundation
import UIKit

class ShareCoordinator: NSObject, Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    weak var parentCoordinator: Coordinator?
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() { }

    func start(with image: UIImage) {
        let shareViewController = ShareViewController()
        shareViewController.coordinator = self
        shareViewController.backgroundImageView.image = image
        navigationController.pushViewController(shareViewController, animated: false)
    }
    
    func popShareViewController() {
        navigationController.popViewController(animated: true)
    }
}
