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
        $0.font = UIFont.setFont(type: .semiBold, size: 22)
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
        setupSubViews()
        setupConstraints()
    }
    
    private func setupSubViews() {
        self.addSubview(timeLabel)
        self.addSubview(weatherImageView)
        self.addSubview(temperatureLabel)
    }
    
    private func setupConstraints() {
        timeLabel.snp.makeConstraints {
            $0.top.equalTo(20)
            $0.centerX.equalToSuperview()
        }
        
        weatherImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(35)
            $0.top.equalTo(timeLabel.snp.bottom).offset(15)
        }
        
        temperatureLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(weatherImageView.snp.bottom).offset(18)
        }
    }
    
    func setupUI(index: Int, data: WeatherData) {
        timeLabel.text = Date(timeIntervalSince1970: TimeInterval(data.hourly[index].dt)).convertToString(dateFormat: "a hh시")
        
        let hourlyWeatherDescription = data.hourly[index].weather.first?.main
        switch hourlyWeatherDescription {
        case "Clear":
            weatherImageView.image = UIImage(named: "sun")
        case "Clouds":
            weatherImageView.image = UIImage(named: "cloud")
        case "Rain":
            weatherImageView.image = UIImage(named: "rain")
        case "Snow":
            weatherImageView.image = UIImage(named: "snow")
        default:
            break
        }
        
        temperatureLabel.text = "\(String(format: "%.0f", round(data.hourly[index].temp)))°"
    }
}
