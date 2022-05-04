//
//  SplashViewController.swift
//  WeatherLook_iOS
//
//  Created by 전소영 on 2022/02/04.
//

import UIKit

import RxSwift

class SplashViewController: UIViewController {
    var viewModel: SplashViewModel?
    
    private let splashImageView = UIImageView().then {
        if let splashImage = UIImage(named: "splashImage") {
            $0.image = splashImage
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: { [weak self] in
            self?.viewModel?.pushWeatherPageViewController()
        })
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
        view.addSubview(splashImageView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        splashImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.equalTo(100)
            $0.height.equalTo(130)
        }
    }
}
