//
//  CurrentWeatherView.swift
//  WeatherLook_iOS
//
//  Created by 전소영 on 2022/02/15.
//

import UIKit

class CurrentWeatherView: UIView {
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.text = "서울시 강남구"
        label.textColor = .white
        label.font = UIFont.setFont(type: .semiBold, size: 32)
        return label
    }()
    
    private let currentTemperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "4'C"
        label.textColor = .white
        label.font = UIFont.setFont(type: .bold, size: 35)
        return label
    }()
    
    private let currentWeatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "splashImage")
        return imageView
    }()
    
    private let currentWeatherDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "맑음"
        label.textColor = .white
        label.font = UIFont.setFont(type: .semiBold, size: 18)
        return label
    }()
    
    private let temperatureLabelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        return stackView
    }()
    
    private let currentMaximumTemperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "최고: 10'C"
        label.textColor = .white
        label.font = UIFont.setFont(type: .medium, size: 14)
        return label
    }()
    
    private let currentMinimumTemperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "최저: -1'C"
        label.textColor = .white
        label.font = UIFont.setFont(type: .medium, size: 14)
        return label
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupLocationLabel()
        setupCurrentTemperatureLabel()
        setupWeatherImageView()
        setupCurrentWeatherDescription()
        setupTemperatureStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
