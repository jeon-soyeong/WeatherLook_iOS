//
//  StickerView.swift
//  WeatherLook_iOS
//
//  Created by 전소영 on 2022/06/15.
//

import UIKit

class StickerView: UIView {
    var stickerImageView = UIImageView()
    private let deleteButton = UIButton().then {
        $0.setImage(UIImage(named: "stickerDelete"), for: .normal)
    }
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        setupSubViews()
        setupConstraints()
    }
    
    private func setupSubViews() {
        self.addSubview(stickerImageView)
        self.addSubview(deleteButton)
    }
    
    private func setupConstraints() {
        stickerImageView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.height.equalTo(100)
        }
        
        deleteButton.snp.makeConstraints {
            $0.top.equalTo(2)
            $0.leading.equalTo(2)
            $0.width.height.equalTo(20)
        }
    }   
}
