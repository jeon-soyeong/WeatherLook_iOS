//
//  SplashViewController.swift
//  WeatherLook_iOS
//
//  Created by 전소영 on 2022/02/04.
//

import UIKit
import RxSwift

class SplashViewController: UIViewController {
    weak var coordinator: SplashCoordinator?
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: { [weak self] in
            self?.coordinator?.goHome()
        })
    }
    
    private func setupUI() {
        let test = UILabel()
        view.backgroundColor = .white
        view.addSubview(test)
        test.text = "splash"
        test.translatesAutoresizingMaskIntoConstraints = false
        test.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        test.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
