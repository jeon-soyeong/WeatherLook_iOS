//
//  ShareViewController.swift
//  WeatherLook_iOS
//
//  Created by 전소영 on 2022/06/17.
//

import UIKit

import RxSwift

class ShareViewController: UIViewController {
    weak var coordinator: ShareCoordinator?
    private let disposeBag = DisposeBag()
    
    var capturedShareImage: UIImage?
    
    let backgroundImageView = UIImageView()
    
    private let shareButton = UIButton().then {
        $0.setImage(UIImage(named: "shareButton"), for: .normal)
    }
    
    private let backButton = UIButton().then {
        $0.setImage(UIImage(named: "backArrow"), for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindAction()
    }
    
    private func setupView() {
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        view.addSubview(backgroundImageView)
        view.addSubview(shareButton)
        view.addSubview(backButton)
    }
    
    private func setupConstraints() {
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        backButton.snp.makeConstraints {
            $0.top.equalTo(52)
            $0.leading.equalTo(24)
            $0.width.height.equalTo(24)
        }
        
        shareButton.snp.makeConstraints {
            $0.top.equalTo(50)
            $0.trailing.equalToSuperview().inset(18)
            $0.width.equalTo(75)
            $0.height.equalTo(30)
        }
    }
    
    private func bindAction() {
        shareButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.shareImage()
            })
            .disposed(by: disposeBag)
        
        backButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.coordinator?.popShareViewController()
            })
            .disposed(by: disposeBag)
    }
    
    private func shareImage() {
        guard let shareImage = backgroundImageView.image else {
            return
        }
        let activityViewController = UIActivityViewController(activityItems: [shareImage], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        activityViewController.completionWithItemsHandler = { (activity, success, items, error) in
            if success {
                if let weatherPageViewController = self.navigationController?.viewControllers[1] {
                    self.navigationController?.popToViewController(weatherPageViewController, animated: false)
                }
            }
        }
        present(activityViewController, animated: true, completion: nil)
    }
}
