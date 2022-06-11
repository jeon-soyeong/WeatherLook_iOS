//
//  StickerPopUpCollectionViewCell.swift
//  WeatherLook_iOS
//
//  Created by 전소영 on 2022/06/10.
//

import UIKit

class StickerPopUpCollectionViewCell: UICollectionViewCell {
    static let cellHeight = 120
    private let stickerImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        self.addSubview(stickerImageView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        stickerImageView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.height.equalTo(80)
        }
    }
    
    func setupUI(index: Int) {
//        stickerImageView.image = UIImage(named: "sticker\(index)")
        stickerImageView.image = UIImage(named: "28temp0")
    }
}
