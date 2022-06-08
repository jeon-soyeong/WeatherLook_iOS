//
//  StickerPopUpCoordinator.swift
//  WeatherLook_iOS
//
//  Created by 전소영 on 2022/06/08.
//

import Foundation
import UIKit

class StickerPopUpCoordinator: NSObject, Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    weak var parentCoordinator: Coordinator?
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let stickerPopUpViewController = StickerPopUpViewController()
        stickerPopUpViewController.coordinator = self
        navigationController.pushViewController(stickerPopUpViewController, animated: false)
    }
}
