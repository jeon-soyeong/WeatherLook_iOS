//
//  SplashViewController.swift
//  WeatherLook_iOS
//
//  Created by 전소영 on 2022/02/04.
//

import UIKit

import RxSwift
import SnapKit

class SplashViewController: UIViewController {
    weak var coordinator: SplashCoordinator?
    
    private let splashImageView: UIImageView = {
        let imageView = UIImageView()
        if let splashImage = UIImage(named: "splashImage") {
            imageView.image = splashImage
        }
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: { [weak self] in
            self?.coordinator?.goHome()
        })
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(splashImageView)
        splashImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.equalTo(100)
            $0.height.equalTo(130)
        }
    }
}
