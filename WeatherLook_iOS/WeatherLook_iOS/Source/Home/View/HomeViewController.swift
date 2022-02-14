//
//  HomeViewController.swift
//  WeatherLook_iOS
//
//  Created by 전소영 on 2022/01/27.
//

import UIKit

import SnapKit

class HomeViewController: UIViewController {
    weak var coordinator: HomeCoordinator?
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .mainBlue
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let currentWeatherView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    private let clothGuideView: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        return view
    }()
    
    private let dayliyWeatherView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()
    
    private let weeklyWeatherView: UIView = {
        let view = UIView()
        view.backgroundColor = .brown
        return view
    }()
    
    private let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let listButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "list"), for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        view.addSubview(bottomView)
        bottomView.snp.makeConstraints {
            $0.centerX.width.bottom.equalToSuperview()
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-50)
        }
        
        bottomView.addSubview(listButton)
        listButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(30)
            $0.width.height.equalTo(25)
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.centerX.top.bottom.equalToSuperview()
        }
        
        contentView.addSubview(currentWeatherView)
        currentWeatherView.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
            $0.height.equalTo(300)
        }
        
        contentView.addSubview(clothGuideView)
        clothGuideView.snp.makeConstraints {
            $0.top.equalTo(currentWeatherView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(150)
        }
        
        contentView.addSubview(dayliyWeatherView)
        dayliyWeatherView.snp.makeConstraints {
            $0.top.equalTo(clothGuideView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(150)
        }
        
        contentView.addSubview(weeklyWeatherView)
        weeklyWeatherView.snp.makeConstraints {
            $0.top.equalTo(dayliyWeatherView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(300)
            $0.bottom.equalToSuperview().inset(50)
        }
    }
    
    func bindViewModel() {
        //rx.tap
    }
    
    func observeViewModel() {
        // view update
    }
}
