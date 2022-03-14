//
//  SearchTableViewCell.swift
//  WeatherLook_iOS
//
//  Created by 전소영 on 2022/03/11.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    let locationNameLabel = UILabel().then {
        $0.textColor = .gray
        $0.font = UIFont.setFont(type: .medium, size: 16)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            self.backgroundColor = .init(white: 1.0, alpha: 0.1)
        } else {
            self.backgroundColor = .none
        }
    }
    
    private func setupView() {
        self.addSubview(locationNameLabel)
        
        locationNameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(48)
            $0.centerY.equalToSuperview()
        }
    }
    
    func setupUI(text: String) {
        locationNameLabel.text = text
    }
}
