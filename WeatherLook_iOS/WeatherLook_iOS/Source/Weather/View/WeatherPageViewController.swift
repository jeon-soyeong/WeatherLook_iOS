//
//  WeatherPageViewController.swift
//  WeatherLook_iOS
//
//  Created by 전소영 on 2022/02/25.
//

import UIKit

import RxSwift
import RxCocoa

class WeatherPageViewController: UIPageViewController {
    weak var coordinator: WeatherCoordinator?
    
    private let disposeBag = DisposeBag()
    private var weatherViewControllers: [WeatherViewController] = []
    var pageIndex: Int = 0
    var locationList: [Location] = []
    
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
        setupWeatherViewControllers()
        setupCurrentWeatherViewController()
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
                        self.locationList.append(currentLocation)
                    }
                }
                UserDefaultsManager.locationList = self.locationList
            })
            .disposed(by: disposeBag)
    }
    
    private func setupWeatherViewControllers() {
        for i in 0..<locationList.count {
            if let weatherViewController = createWeatherViewController(at: i) as? WeatherViewController {
                weatherViewControllers.append(weatherViewController)
            }
        }
    }
    
    private func createWeatherViewController(at index: Int) -> UIViewController {
        let weatherViewController = WeatherViewController()
        weatherViewController.totalPageControlCount = locationList.count
        weatherViewController.currentPageControlIndex = index
        weatherViewController.location = locationList[index]
        
        return weatherViewController
    }
    
    private func setupCurrentWeatherViewController() {
        let currentWeatherViewController = weatherViewControllers[pageIndex]
        setViewControllers([currentWeatherViewController], direction: .forward, animated: false, completion: nil)
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
extension WeatherPageViewController: UIPageViewControllerDelegate { }
