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
        $0.font = UIFont.setFont(type: .semiBold, size: 16)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        self.addSubview(clothingImageView)
        clothingImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(20)
            $0.width.height.equalTo(85)
        }
        
        self.addSubview(clothingTitleLabel)
        clothingTitleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(clothingImageView.snp.bottom).offset(10)
        }
    }
    
    func updateUI(index: Int) {
        //TODO: 변경
//    func updateUI(index: Int, data: WeatherData) {
        let clothingGuide = ClothingGuide()
        let clothingImageName = clothingGuide.getClotingImageName(by: 4) // data.current.temp
        let clothingDescription = clothingGuide.getClotingDescriptions(by: 4)
        
        clothingImageView.image = UIImage(named: "\(clothingImageName)\(index)")
        clothingTitleLabel.text = "\(clothingDescription[index])"
    }
}
