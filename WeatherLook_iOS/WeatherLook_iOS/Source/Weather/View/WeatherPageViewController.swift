//
//  WeatherPageViewController.swift
//  WeatherLook_iOS
//
//  Created by 전소영 on 2022/02/25.
//

import UIKit

class WeatherPageViewController: UIPageViewController {
    weak var coordinator: WeatherCoordinator?
    private var weatherViewControllers: [WeatherViewController] = []
    var pageIndex: Int = 0
    var weatherViewModel = WeatherViewModel()

    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self
        
        setupWeatherViewControllers()
        setupCurrentWeatherViewController()
    }
    
    private func setupWeatherViewControllers() {
        //FIXME: weatherViewModel로 변경
        for i in 0..<5 { //weatherViewModel.weatherData.count {
            if let weatherViewController = createWeatherViewController(at: i) as? WeatherViewController {
                weatherViewControllers.append(weatherViewController)
            }
        }
    }
    
    private func createWeatherViewController(at index: Int) -> UIViewController {
        let weatherViewController = WeatherViewController()
        //FIXME: weatherViewModel로 변경
//        weatherViewController.location = locationList[index]
//        weatherViewController.index = index
        
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
