//
//  WeatherViewController.swift
//  WeatherLook_iOS
//
//  Created by 전소영 on 2022/01/27.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit
import Then

class WeatherViewController: UIViewController {
    private var weatherViewModel: WeatherViewModel?
    private let disposeBag = DisposeBag()
    
    var totalPageControlCount: Int = 0
    var currentPageControlIndex: Int = 0
    var location: Location?
    
    private let scrollView = UIScrollView().then {
        $0.backgroundColor = .mainBlue
        $0.showsVerticalScrollIndicator = false
    }
    
    private let contentView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    private let bottomView = UIView().then {
        $0.backgroundColor = .mainBlue
    }
    
    private let listButton = UIButton().then {
        $0.setImage(UIImage(named: "list"), for: .normal)
    }
    
    private let pageControl = UIPageControl()
    
    private let bottomTopLineView = UIView().then {
        $0.backgroundColor = .mainLineGray
    }
    
    private let currentWeatherLineView = UIView().then {
        $0.backgroundColor = .mainLineGray
    }
    
    private let clothingGuideLineView = UIView().then {
        $0.backgroundColor = .mainLineGray
    }
    
    private let dailyWeatherLineView = UIView().then {
        $0.backgroundColor = .mainLineGray
    }
    
    private let currentWeatherView = CurrentWeatherView()
    
    private let clothingGuideCollectionViewFlowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = .zero
    }
    
    private lazy var clothingGuideCollectionView = UICollectionView.init(frame: .zero, collectionViewLayout: clothingGuideCollectionViewFlowLayout).then {
        $0.showsHorizontalScrollIndicator = false
        $0.backgroundColor = .clear
        $0.isScrollEnabled = false
    }
    
    private let dailyWeatherCollectionViewFlowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = .zero
    }
    
    private lazy var dailyWeatherCollectionView = UICollectionView.init(frame: .zero, collectionViewLayout: dailyWeatherCollectionViewFlowLayout).then {
        $0.showsHorizontalScrollIndicator = false
        $0.backgroundColor = .clear
    }
    
    private let weeklyWeatherCollectionViewFlowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .vertical
        $0.minimumLineSpacing = .zero
    }
    
    private lazy var weeklyWeatherCollectionView = UICollectionView.init(frame: .zero, collectionViewLayout: weeklyWeatherCollectionViewFlowLayout).then {
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = .clear
        $0.isScrollEnabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupPageControl()
        setupCollectionView()
        bindAction()
        bindViewModel()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
        setupSubViews()
        setupConstraints()
    }
    
    private func setupSubViews() {
        view.addSubview(scrollView)
        view.addSubview(bottomView)
        bottomView.addSubview(listButton)
        bottomView.addSubview(pageControl)
        bottomView.addSubview(bottomTopLineView)
        scrollView.addSubview(contentView)
        contentView.addSubview(currentWeatherView)
        contentView.addSubview(currentWeatherLineView)
        contentView.addSubview(clothingGuideCollectionView)
        contentView.addSubview(clothingGuideLineView)
        contentView.addSubview(dailyWeatherCollectionView)
        contentView.addSubview(dailyWeatherLineView)
        contentView.addSubview(weeklyWeatherCollectionView)
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        bottomView.snp.makeConstraints {
            $0.centerX.width.bottom.equalToSuperview()
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-50)
        }
        
        listButton.snp.makeConstraints {
            $0.top.equalTo(18)
            $0.trailing.equalToSuperview().inset(30)
            $0.width.height.equalTo(25)
        }
        
        pageControl.snp.makeConstraints {
            $0.top.equalTo(18)
            $0.centerX.equalToSuperview()
        }
        
        bottomTopLineView.snp.makeConstraints {
            $0.top.centerX.width.equalToSuperview()
            $0.height.equalTo(0.5)
        }
        
        contentView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.centerX.top.bottom.equalToSuperview()
        }
        
        currentWeatherView.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
            $0.height.equalTo(300)
        }
        
        currentWeatherLineView.snp.makeConstraints {
            $0.centerX.width.equalToSuperview()
            $0.top.equalTo(currentWeatherView.snp.bottom)
            $0.height.equalTo(0.5)
        }
        
        clothingGuideCollectionView.snp.makeConstraints {
            $0.top.equalTo(currentWeatherView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(150)
        }
        
        clothingGuideLineView.snp.makeConstraints {
            $0.centerX.width.equalToSuperview()
            $0.top.equalTo(clothingGuideCollectionView.snp.bottom)
            $0.height.equalTo(0.5)
        }
        
        dailyWeatherCollectionView.snp.makeConstraints {
            $0.top.equalTo(clothingGuideCollectionView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(150)
        }
        
        dailyWeatherLineView.snp.makeConstraints {
            $0.centerX.width.equalToSuperview()
            $0.top.equalTo(dailyWeatherCollectionView.snp.bottom)
            $0.height.equalTo(0.5)
        }
        
        weeklyWeatherCollectionView.snp.makeConstraints {
            $0.top.equalTo(dailyWeatherLineView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(300)
            $0.bottom.equalToSuperview().inset(60)
        }
    }
    
    private func setupPageControl() {
        pageControl.numberOfPages = totalPageControlCount
        pageControl.currentPage = currentPageControlIndex
    }
    
    private func setupCollectionView() {
        clothingGuideCollectionView.dataSource = self
        clothingGuideCollectionView.delegate = self
        clothingGuideCollectionView.registerCell(cellType: ClothingGuideCollectionViewCell.self)
        
        dailyWeatherCollectionView.dataSource = self
        dailyWeatherCollectionView.delegate = self
        dailyWeatherCollectionView.registerCell(cellType: DailyWeatherCollectionViewCell.self)
        
        weeklyWeatherCollectionView.dataSource = self
        weeklyWeatherCollectionView.delegate = self
        weeklyWeatherCollectionView.registerCell(cellType: WeeklyWeatherCollectionViewCell.self)
    }
    
    private func bindAction() {
        listButton.rx.tap
            .bind {
                //TODO: list coordinator로 연결
            }
            .disposed(by: disposeBag)
    }
    
    private func bindViewModel() {
        guard let location = location else {
            return
        }
        weatherViewModel = WeatherViewModel(location: location)
        
        let input = WeatherViewModel.Input()
        let output = weatherViewModel?.transform(input: input)
        
        output?.weatherDataResponse
            .subscribe(onNext: { [weak self] _ in
                if let weatherViewModel = self?.weatherViewModel {
                    self?.currentWeatherView.setupView(location: location, viewModel: weatherViewModel)
                }
                self?.clothingGuideCollectionView.reloadData()
                self?.dailyWeatherCollectionView.reloadData()
                self?.weeklyWeatherCollectionView.reloadData()
            })
            .disposed(by: disposeBag)
    }
}

// MARK: UICollectionViewDataSource
extension WeatherViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count: Int = 0
        switch collectionView {
        case clothingGuideCollectionView:
            count = 3
        case dailyWeatherCollectionView:
            if let dailyWeatherCount = weatherViewModel?.weatherData?.hourly.count {
                count = dailyWeatherCount
            }
        case weeklyWeatherCollectionView:
            if let weeaklyWeatherCount = weatherViewModel?.weatherData?.daily.count {
                count = weeaklyWeatherCount
            }
        default:
            count = 7
        }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case clothingGuideCollectionView:
            guard let clothingGuideCollectionViewCell = collectionView.dequeueReusableCell(cellType: ClothingGuideCollectionViewCell.self, indexPath: indexPath) else {
                return UICollectionViewCell()
            }
            if let weatherData = weatherViewModel?.weatherData {
                clothingGuideCollectionViewCell.setupUI(index: indexPath.item, data: weatherData)
            }
            return clothingGuideCollectionViewCell
        case dailyWeatherCollectionView:
            guard let dailyWeatherCollectionViewCell = collectionView.dequeueReusableCell(cellType: DailyWeatherCollectionViewCell.self, indexPath: indexPath) else {
                return UICollectionViewCell()
            }
            
            //            TODO: 실 ViewModel로 변경
            dailyWeatherCollectionViewCell.updateUI()
            
            return dailyWeatherCollectionViewCell
        case weeklyWeatherCollectionView:
            guard let weeklyWeatherCollectionViewCell = collectionView.dequeueReusableCell(cellType: WeeklyWeatherCollectionViewCell.self, indexPath: indexPath) else {
                return UICollectionViewCell()
            }
            
            //            TODO: 실 ViewModel로 변경
            weeklyWeatherCollectionViewCell.updateUI()
            
            return weeklyWeatherCollectionViewCell
        default:
            return UICollectionViewCell()
        }
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension WeatherViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case clothingGuideCollectionView:
            return CGSize(width: Int(collectionView.frame.width) / 3, height: ClothingGuideCollectionViewCell.cellHeight)
        case dailyWeatherCollectionView:
            return CGSize(width: DailyWeatherCollectionViewCell.cellWidth, height: DailyWeatherCollectionViewCell.cellHeight)
        case weeklyWeatherCollectionView:
            return CGSize(width: Int(collectionView.frame.width), height: WeeklyWeatherCollectionViewCell.cellHeight)
        default:
            return CGSize()
        }
    }
}
