//
//  WeatherListTableViewCell.swift
//  WeatherLook_iOS
//
//  Created by 전소영 on 2022/03/07.
//

import UIKit

class WeatherListTableViewCell: UITableViewCell {
    private let locationNameLabel = UILabel().then {
        $0.textColor = .white
        $0.font = UIFont.setFont(type: .medium, size: 30)
    }
    
    private let currentTemperatureLabel = UILabel().then {
        $0.textColor = .white
        $0.font = UIFont.setFont(type: .medium, size: 50)
    }
    
    private let backgroundImageView = UIImageView().then {
        $0.image = UIImage(named: "sky")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        setupSubViews()
        setupConstraints()
    }
    
    private func setupSubViews() {
        self.addSubview(backgroundImageView)
        self.addSubview(locationNameLabel)
        self.addSubview(currentTemperatureLabel)
    }
    
    private func setupConstraints() {
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        locationNameLabel.snp.makeConstraints {
            $0.leading.equalTo(24)
            $0.centerY.equalToSuperview()
        }
        
        currentTemperatureLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(24)
            $0.centerY.equalToSuperview()
        }
    }
    
    //TODO: 실 data로 변경
//    func setupUI(index: Int, data: WeatherData) {
    func setupUI() {
        locationNameLabel.text = "뉴욕 맨해튼"
        currentTemperatureLabel.text = "20°"
    }
}