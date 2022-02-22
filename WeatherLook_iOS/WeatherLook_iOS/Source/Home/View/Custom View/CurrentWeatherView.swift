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
        setupLocationLabel()
        setupCurrentTemperatureLabel()
        setupWeatherImageView()
        setupCurrentWeatherDescription()
        setupTemperatureStackView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLocationLabel()
        setupCurrentTemperatureLabel()
        setupWeatherImageView()
        setupCurrentWeatherDescription()
        setupTemperatureStackView()
    }
    
    private func setupLocationLabel() {
        self.addSubview(locationLabel)
        self.locationLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(14)
        }
    }
    
    private func setupCurrentTemperatureLabel() {
        self.addSubview(currentTemperatureLabel)
        self.currentTemperatureLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(locationLabel.snp.bottom).offset(14)
        }
    }
    
    private func setupWeatherImageView() {
        self.addSubview(currentWeatherImageView)
        self.currentWeatherImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(currentTemperatureLabel.snp.bottom).offset(14)
            $0.width.height.equalTo(100)
        }
    }
    
    private func setupCurrentWeatherDescription() {
        self.addSubview(currentWeatherDescriptionLabel)
        self.currentWeatherDescriptionLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(currentWeatherImageView.snp.bottom).offset(14)
        }
    }
    
    private func setupTemperatureStackView() {
        self.addSubview(temperatureLabelStackView)
        self.temperatureLabelStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(currentWeatherDescriptionLabel.snp.bottom).offset(14)
        }
        temperatureLabelStackView.addArrangedSubview(currentMaximumTemperatureLabel)
        temperatureLabelStackView.addArrangedSubview(currentMinimumTemperatureLabel)
    }
}
