//
//  ClothingGuideCollectionViewCell.swift
//  WeatherLook_iOS
//
//  Created by 전소영 on 2022/02/15.
//

import UIKit

class ClothingGuideCollectionViewCell: UICollectionViewCell {
    static let cellHeight = 148
    
    private let clothingImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let clothingTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.setFont(type: .semiBold, size: 14)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
