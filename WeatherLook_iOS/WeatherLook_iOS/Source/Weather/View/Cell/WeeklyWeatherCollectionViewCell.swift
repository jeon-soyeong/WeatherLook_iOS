//
//  WeeklyWeatherCollectionViewCell.swift
//  WeatherLook_iOS
//
//  Created by 전소영 on 2022/02/18.
//

import UIKit

class WeeklyWeatherCollectionViewCell: UICollectionViewCell {
    //FIXME:  viewModel 갯수로 수정
    static let cellHeight = 300 / 7
    
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
            $0.leading.equalTo(weatherImageView.snp.trailing).offset(12)
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
    
    // TODO: 실제로 변경
    func updateUI() {
        daysLabel.text = "월요일"
        weatherImageView.image = UIImage(named: "sun")
        precipitationProbabilityLabel.text = "10%"
        maximumTemperatureLabel.text = "11"
        minimumTemperatureLabel.text = "9"
    }
}