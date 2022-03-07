//
//  ClothingGuideCollectionViewCell.swift
//  WeatherLook_iOS
//
//  Created by 전소영 on 2022/02/15.
//

import UIKit

class ClothingGuideCollectionViewCell: UICollectionViewCell {
    static let cellHeight = 150
    
    private let clothingImageView = UIImageView()
    private let clothingTitleLabel = UILabel().then {
        $0.textColor = .white
        $0.font = UIFont.setFont(type: .semiBold, size: 18)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        self.addSubview(clothingImageView)
        self.addSubview(clothingTitleLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        clothingImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(20)
            $0.width.height.equalTo(85)
        }
        
        clothingTitleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(clothingImageView.snp.bottom).offset(10)
        }
    }
   
    func setupUI(index: Int, data: WeatherData) {
        let clothingGuide = ClothingGuide()
        let clothingImageName = clothingGuide.getClothingImageName(by: Int(data.current.temp))
        let clothingDescription = clothingGuide.getClothingDescriptions(by: Int(data.current.temp))
        
        clothingImageView.image = UIImage(named: "\(clothingImageName)\(index)")
        clothingTitleLabel.text = "\(clothingDescription[index])"
    }
}
