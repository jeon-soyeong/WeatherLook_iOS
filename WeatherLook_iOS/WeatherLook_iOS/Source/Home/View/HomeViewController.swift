//
//  HomeViewController.swift
//  WeatherLook_iOS
//
//  Created by 전소영 on 2022/01/27.
//

import UIKit

class HomeViewController: UIViewController {
    weak var coordinator: HomeCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
    }
}

