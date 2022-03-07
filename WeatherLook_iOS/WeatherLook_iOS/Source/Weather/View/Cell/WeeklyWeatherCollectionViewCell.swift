//
//  WeeklyWeatherCollectionViewCell.swift
//  WeatherLook_iOS
//
//  Created by 전소영 on 2022/02/18.
//

import UIKit

class WeeklyWeatherCollectionViewCell: UICollectionViewCell {
    static let cellHeight = 300
    
    private let daysLabel = UILabel().then {
        $0.textColor = .white
        $0.font = UIFont.setFont(type: .semiBold, size: 18)
    }
    
    private let weatherImageView = UIImageView()
    
    private let precipitationProbabilityLabel = UILabel().then {
        $0.textColor = .white
        $0.font = UIFont.setFont(type: .semiBold, size: 18)
    }
    
    private let maximumTemperatureLabel = UILabel().then {
        $0.textColor = .white
        $0.font = UIFont.setFont(type: .semiBold, size: 18)
    }
    
    private let minimumTemperatureLabel = UILabel().then {
        $0.textColor = .mainLineGray
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
        setupSubViews()
        setupConstraints()
    }
    
    private func setupSubViews() {
        self.addSubview(daysLabel)
        self.addSubview(weatherImageView)
        self.addSubview(precipitationProbabilityLabel)
        self.addSubview(minimumTemperatureLabel)
        self.addSubview(maximumTemperatureLabel)
    }
    
    private func setupConstraints() {
        daysLabel.snp.makeConstraints {
            $0.leading.equalTo(24)
            $0.top.equalTo(15)
        }
        
        weatherImageView.snp.makeConstraints {
            $0.top.equalTo(12)
            $0.leading.equalTo(daysLabel.snp.trailing).offset(90)
            $0.width.height.equalTo(25)
        }
        
        precipitationProbabilityLabel.snp.makeConstraints {
            $0.top.equalTo(15)
            $0.leading.equalTo(weatherImageView.snp.trailing).offset(16)
        }
        
        minimumTemperatureLabel.snp.makeConstraints {
            $0.top.equalTo(15)
            $0.leading.equalTo(self.snp.trailing).inset(36)
        }
        
        maximumTemperatureLabel.snp.makeConstraints {
            $0.top.equalTo(15)
            $0.leading.equalTo(minimumTemperatureLabel.snp.leading).offset(-36)
        }
    }
    
    func setupUI(index: Int, data: WeatherData) {
        daysLabel.text = Date(timeIntervalSince1970: TimeInterval(data.daily[index].dt)).convertToString(dateFormat: "e").convertToDays()
        
        let dailyWeatherDescription = data.daily[index].weather.first?.main
        switch dailyWeatherDescription {
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
        
        let dailyPrecipitationProbability = data.daily[index].pop
        switch dailyPrecipitationProbability {
        case 0:
            precipitationProbabilityLabel.text = ""
        case 1:
            precipitationProbabilityLabel.text = "100%"
        default:
            let precipitationProbability = String(format: "%.0f", round(dailyPrecipitationProbability) * 10)
            if precipitationProbability != "0" {
                precipitationProbabilityLabel.text = "\(precipitationProbability)%"
            }
        }
        
        maximumTemperatureLabel.text = String(format: "%.0f", round(data.daily[index].temp.max))
        minimumTemperatureLabel.text = String(format: "%.0f", round(data.daily[index].temp.min))
    }
}
