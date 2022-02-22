//
//  DailyWeatherCollectionViewCell.swift
//  WeatherLook_iOS
//
//  Created by 전소영 on 2022/02/18.
//

import UIKit

class DailyWeatherCollectionViewCell: UICollectionViewCell {
    static let cellWidth = 100
    static let cellHeight = 150
    
    private let timeLabel = UILabel().then {
        $0.textColor = .white
        $0.font = UIFont.setFont(type: .semiBold, size: 18)
    }
    
    private let weatherImageView = UIImageView()
    
    private let temperatureLabel = UILabel().then {
        $0.textColor = .white
        $0.font = UIFont.setFont(type: .semiBold, size: 18)
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
        self.addSubview(timeLabel)
        timeLabel.snp.makeConstraints {
            $0.top.equalTo(20)
            $0.centerX.equalToSuperview()
        }
        
        self.addSubview(weatherImageView)
        weatherImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(35)
            $0.top.equalTo(timeLabel.snp.bottom).offset(15)
        }
        
        self.addSubview(temperatureLabel)
        temperatureLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(weatherImageView.snp.bottom).offset(18)
        }
    }
    
    // TODO: 실제로 변경
    func updateUI() {
        timeLabel.text = "오전 10시"
        weatherImageView.image = UIImage(named: "sun")
        temperatureLabel.text = "맑음"
    }
}
