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
        previewViewController.capturedPreviewImageView.image = image
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
    
    func pushShareViewController(with image: UIImage) {
        let shareCoordinator = ShareCoordinator(navigationController)
        shareCoordinator.parentCoordinator = self
        self.childCoordinators.append(shareCoordinator)
        
        shareCoordinator.start(with: image)
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

// MARK: UINavigationControllerDelegate
extension PreViewCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }
        
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
   
        if let shareViewController = fromViewController as? ShareViewController {
            removeChildCoordinator(shareViewController.coordinator)
        }
    }
}
