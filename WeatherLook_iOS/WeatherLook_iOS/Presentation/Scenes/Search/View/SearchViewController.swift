//
//  SearchViewController.swift
//  WeatherLook_iOS
//
//  Created by 전소영 on 2022/03/10.
//

import UIKit

import MapKit
import RxSwift

class SearchViewController: UIViewController {
    var viewModel: SearchViewModel?
    
    private var searchCompleter = MKLocalSearchCompleter()
    private var searchResults = [MKLocalSearchCompletion]()
    private let disposeBag = DisposeBag()
    
    private let topView = UIView().then {
        $0.backgroundColor = .lightGray.withAlphaComponent(0.6)
    }
    
    private let inputGuideLabel = UILabel().then {
        $0.text = "도시, 우편번호 또는 공항 위치 입력"
        $0.font = UIFont.setFont(type: .regular, size: 14)
        $0.textColor = .white
    }
    
    private let searchBar = UISearchBar().then {
        $0.becomeFirstResponder()
        $0.showsCancelButton = false
        $0.searchBarStyle = .minimal
        $0.keyboardAppearance = .dark
        $0.searchTextField.leftView?.tintColor = .white.withAlphaComponent(0.5)
        $0.searchTextField.backgroundColor = .lightGray
        $0.searchTextField.font = UIFont.setFont(type: .semiBold, size: 17)
        $0.searchTextField.textColor = .white
        $0.searchTextField.tintColor = .white
        $0.searchTextField.attributedPlaceholder = NSAttributedString(string: "검색",
                                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.5)])
    }
    
    private let cancelButton = UIButton().then {
        $0.setTitle("취소", for: .normal)
        $0.titleLabel?.font = UIFont.setFont(type: .semiBold, size: 17)
        $0.tintColor = .white
        $0.backgroundColor = .clear
    }
    
    private let bottomLineView = UIView().then {
        $0.backgroundColor = .lightGray
    }
    
    private let searchTableView = UITableView().then {
        $0.backgroundColor = .clear
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupTableView()
        setupSearchCompleter()
        bindAction()
    }
    
    private func setupView() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        setupBlurEffect()
        setupSubViews()
        setupConstraints()
    }
    
    private func setupBlurEffect() {
        let blurEffect = UIBlurEffect(style: .dark)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.frame = view.frame
        view.addSubview(visualEffectView)
        topView.addSubview(visualEffectView)
    }
    
    private func setupSubViews() {
        view.addSubview(topView)
        view.addSubview(searchTableView)
        topView.addSubview(inputGuideLabel)
        topView.addSubview(searchBar)
        topView.addSubview(cancelButton)
        topView.addSubview(bottomLineView)
    }
    
    private func setupConstraints() {
        topView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(105)
        }
        
        inputGuideLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(14)
            $0.centerX.equalToSuperview()
        }
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(inputGuideLabel.snp.bottom).offset(18)
            $0.leading.equalToSuperview().inset(8)
            $0.trailing.equalTo(cancelButton.snp.leading).offset(-2)
            $0.height.equalTo(40)
        }
        
        cancelButton.snp.makeConstraints {
            $0.centerY.equalTo(searchBar.snp.centerY)
            $0.trailing.equalToSuperview().inset(14)
        }
        
        bottomLineView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(0.5)
        }
        
        searchTableView.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setupTableView() {
        searchTableView.dataSource = self
        searchTableView.delegate = self
        searchTableView.registerCell(cellType: SearchTableViewCell.self)
        searchTableView.separatorStyle = .none
    }
    
    private func setupSearchCompleter() {
        searchCompleter.delegate = self
        searchCompleter.resultTypes = .address
    }
    
    private func bindAction() {
        cancelButton.rx.tap
            .subscribe(onNext: {
                self.viewModel?.dismiss()
            })
            .disposed(by: disposeBag)
        
        searchBar.rx.text.orEmpty
            .subscribe(onNext: { [unowned self] query in
                searchTableView.reloadData()
                searchCompleter.queryFragment = query
            })
            .disposed(by: disposeBag)
    }
}

// MARK: UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let searchTableViewCell = tableView.dequeueReusableCell(cellType: SearchTableViewCell.self, indexPath: indexPath) else {
            return UITableViewCell()
        }
        
        searchTableViewCell.backgroundColor = .clear
        searchTableViewCell.selectionStyle = .none
        searchTableViewCell.setupUI(text: searchResults[indexPath.row].title)
        if let highlightText = searchBar.text {
            searchTableViewCell.locationNameLabel.setHighlight(searchResults[indexPath.row].title, with: highlightText)
        }
        
        return searchTableViewCell
    }
}

// MARK: UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedResult = searchResults[indexPath.row]
        let searchReqeust = MKLocalSearch.Request(completion: selectedResult)
        let search = MKLocalSearch(request: searchReqeust)
        search.start { (response, error) in
            guard let searchLatitude = response?.mapItems.first?.placemark.coordinate.latitude,
                  let searchLongtitude = response?.mapItems.first?.placemark.coordinate.longitude else {
                      return
                  }
            
            var locationName = ""
            let administrativeArea = response?.mapItems.first?.placemark.administrativeArea ?? ""
            let locality = response?.mapItems.first?.placemark.locality ?? ""
            let subLocality = response?.mapItems.first?.placemark.subLocality ?? ""
            let country = response?.mapItems.first?.placemark.country ?? ""
            
            if locality.isEmpty {
                if administrativeArea.isEmpty, subLocality.isEmpty {
                    locationName = "\(country)"
                } else {
                    locationName = "\(administrativeArea) \(subLocality)"
                }
            } else if subLocality.isEmpty {
                locationName = "\(administrativeArea) \(locality)"
            } else if administrativeArea.isEmpty {
                locationName = "\(locality) \(subLocality)"
            } else {
                locationName = "\(locality) \(subLocality)"
            }
            
            self.viewModel?.presentWeatherViewController(with: Location(coordinate: Coordinate(latitude: searchLatitude, longitude: searchLongtitude), name: locationName))
            
            guard error == nil else {
                print(error.debugDescription)
                return
            }
        }
    }
}

// MARK: MKLocalSearchCompleterDelegate
extension SearchViewController: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
        searchTableView.reloadData()
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

// MARK: UIScrollViewDelegate
extension SearchViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.searchBar.resignFirstResponder()
    }
}
