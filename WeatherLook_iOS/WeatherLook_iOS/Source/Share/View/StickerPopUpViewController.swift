//
//  StickerPopUpViewController.swift
//  WeatherLook_iOS
//
//  Created by 전소영 on 2022/06/08.
//

import UIKit

import RxSwift

class StickerPopUpViewController: UIViewController {
    weak var coordinator: StickerPopUpCoordinator?
    private let disposeBag = DisposeBag()
    
    private let stickerPopUpViewHeight: CGFloat = 359
    
    private let backgroundView = UIView().then {
        $0.backgroundColor = .transparentGrey
    }
    
    private let stickerPopUpView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.clipsToBounds = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupGestureRecognizer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showStickerPopUpView()
    }
    
    private func setupView() {
        backgroundView.alpha = 0.0
        
        setupSubViews()
        setupConstraints()
    }
    
    private func setupSubViews() {
        view.addSubview(backgroundView)
        view.addSubview(stickerPopUpView)
    }
    
    private func setupConstraints() {
        backgroundView.snp.makeConstraints {
            $0.centerX.centerY.width.height.equalToSuperview()
        }
        
        stickerPopUpView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            let topConstant = view.safeAreaLayoutGuide.layoutFrame.height + view.safeAreaInsets.bottom
            $0.top.equalTo(topConstant)
        }
    }
    
    private func setupGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
        backgroundView.addGestureRecognizer(tapGestureRecognizer)
        backgroundView.isUserInteractionEnabled = true
        
        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        swipeGestureRecognizer.direction = UISwipeGestureRecognizer.Direction.down
        view.addGestureRecognizer(swipeGestureRecognizer)
    }
    
    @objc private func handleTapGesture(_ gestureRecognizer: UITapGestureRecognizer) {
        hideStickerPopUpView()
    }
    
    @objc private func handleSwipeGesture(_ gestureRecognizer: UISwipeGestureRecognizer) {
        if gestureRecognizer.state == .ended {
            switch gestureRecognizer.direction {
            case .down:
                hideStickerPopUpView()
            default:
                break
            }
        }
    }
    
    private func showStickerPopUpView() {
        stickerPopUpView.snp.makeConstraints {
            let topConstant = (view.safeAreaLayoutGuide.layoutFrame.height + view.safeAreaInsets.bottom) - stickerPopUpViewHeight
            $0.top.equalTo(topConstant)
        }
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.backgroundView.alpha = 0.5
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func hideStickerPopUpView() {
        stickerPopUpView.snp.makeConstraints {
            let topConstant = view.safeAreaLayoutGuide.layoutFrame.height + view.safeAreaInsets.bottom
            $0.top.equalTo(topConstant)
        }
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.backgroundView.alpha = 0.0
            self.view.layoutIfNeeded()
        }) { _ in
            if self.presentingViewController != nil {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}
