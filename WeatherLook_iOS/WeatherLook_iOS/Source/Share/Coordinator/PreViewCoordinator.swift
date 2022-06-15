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
    
    func start() { }
    
    func start(with image: UIImage) {
        let previewViewController = PreviewViewController()
        previewViewController.coordinator = self
        previewViewController.imageView.image = image
        navigationController.pushViewController(previewViewController, animated: false)
    }
    
    func popPreviewViewController() {
        navigationController.popViewController(animated: true)
    }
    
    func presentStickerPopUpViewController(completion: ((Int) -> Void)? = nil) {
        let stickerPopUpCoordinator = StickerPopUpCoordinator(navigationController)
        stickerPopUpCoordinator.parentCoordinator = self
        self.childCoordinators.append(stickerPopUpCoordinator)
        
        stickerPopUpCoordinator.start(completion: completion)
    }
}
