//
//  PreviewViewController.swift
//  WeatherLook_iOS
//
//  Created by 전소영 on 2022/06/07.
//

import UIKit

class PreviewViewController: UIViewController {
    weak var coordinator: PreViewCoordinator?
    var imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        view.addSubview(imageView)
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints {
            $0.centerX.centerY.width.height.equalToSuperview()
        }
    }
}
