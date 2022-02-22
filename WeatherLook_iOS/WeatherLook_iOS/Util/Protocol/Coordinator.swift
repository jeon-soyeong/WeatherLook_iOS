//
//  Coordinator.swift
//  WeatherLook_iOS
//
//  Created by 전소영 on 2022/02/04.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    var childCoordinators: [Coordinator] { get set }
    
    func start()
}
