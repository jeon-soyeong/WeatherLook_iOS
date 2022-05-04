//
//  WeatherPageViewController.swift
//  WeatherLook_iOS
//
//  Created by 전소영 on 2022/02/25.
//

import UIKit

import RxSwift

class WeatherPageViewController: UIPageViewController {
    weak var weatherCoordinator: WeatherCoordinator?
    
    private let disposeBag = DisposeBag()
    private var weatherViewControllers: [WeatherViewController] = []
    var viewModel: WeatherPageViewModel?
    var pageIndex: Int = 0
    var locationList: [Location] = []
    
    private let bottomView = UIView().then {
        $0.backgroundColor = .mainBlue
    }
    
    private let bottomTopLineView = UIView().then {
        $0.backgroundColor = .mainLineGray
    }
    
    private let listButton = UIButton().then {
        $0.setImage(UIImage(named: "list"), for: .normal)
    }
    
    override init(transitionStyle: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey: Any]?) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self
        
        setupLocationList()
        setupView()
        bindAction()
    }
    
    private func setupView() {
        view.backgroundColor = .mainBlue
        
        setupSubViews()
        setupConstraints()
    }
    
    private func setupSubViews() {
        view.addSubview(bottomView)
        bottomView.addSubview(listButton)
        bottomView.addSubview(bottomTopLineView)
    }
    
    private func setupConstraints() {
        bottomView.snp.makeConstraints {
            $0.centerX.width.bottom.equalToSuperview()
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-50)
        }
        
        bottomTopLineView.snp.makeConstraints {
            $0.top.centerX.width.equalToSuperview()
            $0.height.equalTo(0.5)
        }
        
        listButton.snp.makeConstraints {
            $0.top.equalTo(20)
            $0.trailing.equalToSuperview().inset(30)
            $0.width.height.equalTo(25)
        }
    }
    
    private func setupLocationList() {
        var latitude: Double = 0
        var longitude: Double = 0
        var name: String = ""
        
        if let userLocationList = UserDefaultsManager.locationList {
            locationList = userLocationList
        }
        
        Observable.zip(LocationManager.shared.locationSubject, LocationManager.shared.placeMarkSubject)
            .subscribe(onNext: { value in
                latitude = value.0.latitude
                longitude = value.0.longitude
                name = value.1
                
                let currentLocation = Location(coordinate: Coordinate(latitude: latitude, longitude: longitude), name: name)
                
                if self.locationList.isEmpty {
                    self.locationList.append(currentLocation)
                } else {
                    if self.locationList.first != currentLocation {
                        self.locationList.remove(at: 0)
                        self.locationList.insert(currentLocation, at: 0)
                    }
                }
                UserDefaultsManager.locationList = self.locationList
                
                self.setupWeatherViewControllers()
                self.setupCurrentWeatherViewController()
            })
            .disposed(by: disposeBag)
    }
    
    private func setupWeatherViewControllers() {
        weatherViewControllers = []
        for i in 0..<locationList.count {
            if let weatherViewController = createWeatherViewController(at: i) as? WeatherViewController {
                weatherViewControllers.append(weatherViewController)
            }
        }
    }
    
    private func createWeatherViewController(at index: Int) -> UIViewController {
        let weatherViewController = WeatherViewController()
        weatherViewController.viewModel = WeatherViewModel(coordinator: weatherCoordinator, weatherUseCase: WeatherUseCase(weatherRepository: DefaultWeatherRepository()))
        weatherViewController.location = locationList[index]
        
        return weatherViewController
    }
    
    private func setupCurrentWeatherViewController() {
        let currentWeatherViewController = weatherViewControllers[pageIndex]
        setViewControllers([currentWeatherViewController], direction: .forward, animated: false, completion: nil)
    }
    
    private func bindAction() {
        listButton.rx.tap
            .subscribe(onNext: {
                self.viewModel?.pushWeatherListViewController(completion: { [weak self] index in
                    self?.pageIndex = index
                    
                    if let userLocationList = UserDefaultsManager.locationList {
                        self?.locationList = userLocationList
                    }
                    
                    self?.setupWeatherViewControllers()
                    self?.setupCurrentWeatherViewController()
                })
            })
            .disposed(by: disposeBag)
    }
}

// MARK: UIPageViewControllerDataSource
extension WeatherPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let weatherViewController = viewController as? WeatherViewController, let currentIndex = weatherViewControllers.firstIndex(of: weatherViewController) else {
            return nil
        }
        
        let previousIndex = currentIndex - 1
        
        if previousIndex < 0 {
            return weatherViewControllers.last
        } else {
            return weatherViewControllers[previousIndex]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let weatherViewController = viewController as? WeatherViewController, let currentIndex = weatherViewControllers.firstIndex(of: weatherViewController) else {
            return nil
        }
        
        let nextIndex = currentIndex + 1
        
        if nextIndex >= weatherViewControllers.count {
            return weatherViewControllers.first
        } else {
            return weatherViewControllers[nextIndex]
        }
    }
}

// MARK: UIPageViewControllerDelegate
extension WeatherPageViewController: UIPageViewControllerDelegate {
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return weatherViewControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let currentViewController = viewControllers?.first as? WeatherViewController,
              let currentViewControllerIndex = weatherViewControllers.firstIndex(of: currentViewController) else {
                  return 0
              }
        
        return currentViewControllerIndex
    }
}
