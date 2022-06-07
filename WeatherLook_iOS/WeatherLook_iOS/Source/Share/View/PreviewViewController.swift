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
    
    private let deleteButton = UIButton().then {
        $0.setImage(UIImage(named: "delete"), for: .normal)
    }
    
    private let stickerButton = UIButton().then {
        $0.setImage(UIImage(named: "sticker"), for: .normal)
    }
    
    private let arrowButton = UIButton().then {
        $0.setImage(UIImage(named: "arrow"), for: .normal)
    }
    
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
        view.addSubview(deleteButton)
        view.addSubview(stickerButton)
        view.addSubview(arrowButton)
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints {
            $0.centerX.centerY.width.height.equalToSuperview()
        }
        
        deleteButton.snp.makeConstraints {
            $0.top.equalTo(54)
            $0.leading.equalToSuperview().inset(24)
            $0.width.height.equalTo(18)
        }
        
        stickerButton.snp.makeConstraints {
            $0.top.equalTo(50)
            $0.trailing.equalToSuperview().inset(60)
            $0.width.height.equalTo(28)
        }
        
        arrowButton.snp.makeConstraints {
            $0.top.equalTo(54)
            $0.trailing.equalToSuperview().inset(22)
            $0.width.height.equalTo(22)
        }
    }
}
