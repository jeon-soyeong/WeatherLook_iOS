//
//  WeatherListViewController.swift
//  WeatherLook_iOS
//
//  Created by 전소영 on 2022/03/07.
//

import UIKit

import RxSwift

class WeatherListViewController: UIViewController {
    weak var coordinator: WeatherListCoordinator?
    private let disposeBag = DisposeBag()
    private var weatherViewModel = WeatherViewModel()
    var locationList: [Location] = []
    var weatherDatas: [WeatherData] = []
    var completion: ((Int) -> Void)?
    
    private let weatherListTableView = UITableView().then {
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = .black
    }
    
    private let footerView = UIView().then {
        $0.backgroundColor = .black
        $0.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 95)
    }
    
    private let searchButton = UIButton().then {
        $0.setImage(UIImage(named: "search"), for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupTableView()
        bindAction()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchWeatherData()
    }
    
    private func setupView() {
        view.addSubview(weatherListTableView)
        footerView.addSubview(searchButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        weatherListTableView.snp.makeConstraints {
            $0.centerX.centerY.width.height.equalToSuperview()
        }
        
        searchButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(30)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(28)
        }
    }
    
    private func setupTableView() {
        weatherListTableView.dataSource = self
        weatherListTableView.delegate = self
        weatherListTableView.registerCell(cellType: WeatherListTableViewCell.self)
        weatherListTableView.tableFooterView = footerView
    }
    
    private func fetchWeatherData() {
        if let locations = UserDefaultsManager.locationList {
            locationList = locations
        }
        
        for i in 0..<locationList.count {
            weatherViewModel.action.fetch.onNext(locationList[i])
        }
    }
    
    private func bindAction() {
        searchButton.rx.tap
            .subscribe(onNext: {
                print("searchButton Tapped")
            })
            .disposed(by: disposeBag)
    }
    
    private func bindViewModel() {
        weatherViewModel.state.weatherDataResponse
            .subscribe(onNext: { [weak self] data in
                self?.weatherDatas.append(data)
                self?.weatherListTableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
}

// MARK: UITableViewDataSource
extension WeatherListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let weatherListTableViewCell = tableView.dequeueReusableCell(cellType: WeatherListTableViewCell.self, indexPath: indexPath) else {
            return UITableViewCell()
        }
        weatherListTableViewCell.setupUI(location:locationList[indexPath.row] ,data: weatherDatas[indexPath.row])
        return weatherListTableViewCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 110
        } else {
            return 95
        }
    }
}

// MARK: UITableViewDelegate
extension WeatherListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        completion?(indexPath.row)
        coordinator?.popWeatherListViewController()
    }
}
