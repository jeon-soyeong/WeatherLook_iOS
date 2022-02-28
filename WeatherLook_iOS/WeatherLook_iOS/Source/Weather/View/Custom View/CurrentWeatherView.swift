//
//  CurrentWeatherView.swift
//  WeatherLook_iOS
//
//  Created by 전소영 on 2022/02/15.
//

import UIKit

class CurrentWeatherView: UIView {
    private let locationLabel = UILabel().then {
        $0.text = "서울시 강남구"
        $0.textColor = .white
        $0.font = UIFont.setFont(type: .semiBold, size: 32)
    }
    
    private let currentTemperatureLabel = UILabel().then {
        $0.text = "4'C"
        $0.textColor = .white
        $0.font = UIFont.setFont(type: .bold, size: 35)
    }
    
    private let currentWeatherImageView = UIImageView().then {
        $0.image = UIImage(named: "sun")
    }
    
    private let currentWeatherDescriptionLabel = UILabel().then {
        $0.text = "맑음"
        $0.textColor = .white
        $0.font = UIFont.setFont(type: .semiBold, size: 18)
    }
    
    private let temperatureLabelStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 20
    }
    
    private let currentMaximumTemperatureLabel = UILabel().then {
        $0.text = "최고: 10'C"
        $0.textColor = .white
        $0.font = UIFont.setFont(type: .medium, size: 14)
    }
    
    private let currentMinimumTemperatureLabel = UILabel().then {
        $0.text = "최저: -1'C"
        $0.textColor = .white
        $0.font = UIFont.setFont(type: .medium, size: 14)
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
        self.addSubview(locationLabel)
        self.addSubview(currentTemperatureLabel)
        self.addSubview(currentWeatherImageView)
        self.addSubview(currentWeatherDescriptionLabel)
        self.addSubview(temperatureLabelStackView)
        temperatureLabelStackView.addArrangedSubview(currentMaximumTemperatureLabel)
        temperatureLabelStackView.addArrangedSubview(currentMinimumTemperatureLabel)
    }
    
    private func setupConstraints() {
        self.locationLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(14)
        }
        
        self.currentTemperatureLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(locationLabel.snp.bottom).offset(14)
        }
        
        self.currentWeatherImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(currentTemperatureLabel.snp.bottom).offset(14)
            $0.width.height.equalTo(100)
        }
        
        self.currentWeatherDescriptionLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(currentWeatherImageView.snp.bottom).offset(14)
        }
        
        self.temperatureLabelStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(currentWeatherDescriptionLabel.snp.bottom).offset(14)
        }
    }
}
