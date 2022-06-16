//
//  StickerView.swift
//  WeatherLook_iOS
//
//  Created by 전소영 on 2022/06/15.
//

import UIKit

import RxSwift

class StickerView: UIView {
    private let disposeBag = DisposeBag()
    
    var stickerImageView = UIImageView()
    private let deleteButton = UIButton().then {
        $0.setImage(UIImage(named: "stickerDelete"), for: .normal)
    }
    private var beginningPoint = CGPoint.zero
    private var beginningCenter = CGPoint.zero
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
        setupGestureRecognizer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupGestureRecognizer()
    }
    
    private func setupView() {
        setupSubViews()
        setupConstraints()
    }
    
    private func setupSubViews() {
        self.addSubview(stickerImageView)
        self.addSubview(deleteButton)
    }
    
    private func setupConstraints() {
        stickerImageView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.height.equalTo(100)
        }
        
        deleteButton.snp.makeConstraints {
            $0.top.equalTo(2)
            $0.leading.equalTo(2)
            $0.width.height.equalTo(20)
        }
    }
    
    private func setupGestureRecognizer() {
        let panGestureRecognizer = UIPanGestureRecognizer()
        panGestureRecognizer.delaysTouchesBegan = false
        panGestureRecognizer.delaysTouchesEnded = false
        self.addGestureRecognizer(panGestureRecognizer)
        
        let pinchGestureRecognizer = UIPinchGestureRecognizer()
        self.addGestureRecognizer(pinchGestureRecognizer)
        
        let rotationGestureRecognizer = UIRotationGestureRecognizer()
        self.addGestureRecognizer(rotationGestureRecognizer)
        
        panGestureRecognizer.rx.event
            .subscribe(onNext: { [weak self] _ in
                self?.handlePanGesture(panGestureRecognizer)
            })
            .disposed(by: disposeBag)
        
        pinchGestureRecognizer.rx.event
            .subscribe(onNext: { [weak self] _ in
                self?.handlePinchGesture(pinchGestureRecognizer)
            })
            .disposed(by: disposeBag)
        
        rotationGestureRecognizer.rx.event
            .subscribe(onNext: { [weak self] _ in
                self?.handleRotationGesture(rotationGestureRecognizer)
            })
            .disposed(by: disposeBag)
    }
    
    private func handlePanGesture(_ gestureRecognizer: UIPanGestureRecognizer) {
        let touchLocation = gestureRecognizer.location(in: self.superview)
        switch gestureRecognizer.state {
        case .began:
            self.beginningPoint = touchLocation
            self.beginningCenter = self.center
        case .changed:
            self.center = CGPoint(x: self.beginningCenter.x + (touchLocation.x - self.beginningPoint.x), y: self.beginningCenter.y + (touchLocation.y - self.beginningPoint.y))
        case .ended:
            self.center = CGPoint(x: self.beginningCenter.x + (touchLocation.x - self.beginningPoint.x), y: self.beginningCenter.y + (touchLocation.y - self.beginningPoint.y))
        default:
            break
        }
    }
    
    private func handlePinchGesture(_ gestureRecognizer: UIPinchGestureRecognizer) {
        guard let gestureView = gestureRecognizer.view else {
            return
        }
        
        gestureView.transform = gestureView.transform.scaledBy(
            x: gestureRecognizer.scale,
            y: gestureRecognizer.scale
        )
        gestureRecognizer.scale = 1
    }
    
    private func handleRotationGesture(_ gestureRecognizer: UIRotationGestureRecognizer) {
        guard let gestureView = gestureRecognizer.view else {
            return
        }
        
        gestureView.transform = gestureView.transform.rotated(
            by: gestureRecognizer.rotation
        )
        gestureRecognizer.rotation = 0
    }
}
