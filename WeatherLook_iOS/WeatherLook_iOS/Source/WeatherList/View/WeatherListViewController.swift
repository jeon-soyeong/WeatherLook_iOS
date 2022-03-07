//
//  WeatherListViewController.swift
//  WeatherLook_iOS
//
//  Created by 전소영 on 2022/03/07.
//

import UIKit

class WeatherListViewController: UIViewController {
    weak var coordinator: WeatherListCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .white

        setupConstraints()
    }
    
    private func setupConstraints() {
        
    }
}
