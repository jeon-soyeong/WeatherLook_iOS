//
//  PreviewViewController.swift
//  WeatherLook_iOS
//
//  Created by 전소영 on 2022/06/07.
//

import UIKit

import RxSwift

class PreviewViewController: UIViewController {
    weak var coordinator: PreViewCoordinator?
    private let disposeBag = DisposeBag()
    
    var imageView = UIImageView()
    
    private let deleteButton = UIButton().then {
        $0.setImage(UIImage(named: "delete"), for: .normal)
    }
    
    private let stickerButton = UIButton().then {
        $0.setImage(UIImage(named: "sticker"), for: .normal)
    }
    
    private let arrowButton = UIButton().then {
        $0.setImage(UIImage(named: "arrow"), for: .normal)
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
        view.addSubview(imageView)
        view.addSubview(deleteButton)
        view.addSubview(stickerButton)
        view.addSubview(arrowButton)
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints {
            $0.centerX.centerY.width.height.equalToSuperview()
        }
        
        deleteButton.snp.makeConstraints {
            $0.top.equalTo(54)
            $0.leading.equalToSuperview().inset(24)
            $0.width.height.equalTo(18)
        }
        
        stickerButton.snp.makeConstraints {
            $0.top.equalTo(50)
            $0.trailing.equalToSuperview().inset(60)
            $0.width.height.equalTo(28)
        }
        
        arrowButton.snp.makeConstraints {
            $0.top.equalTo(54)
            $0.trailing.equalToSuperview().inset(22)
            $0.width.height.equalTo(22)
        }
    }
    
    private func bindAction() {
        deleteButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.coordinator?.popPreviewViewController()
            })
            .disposed(by: disposeBag)
        
        stickerButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.coordinator?.presentStickerPopUpViewController(completion: { [weak self] index in
                    self?.addStickerView(index: index)
                })
            })
            .disposed(by: disposeBag)
    }
    
    private func addStickerView(index: Int) {
        let stickerImageView = UIImageView().then {
            $0.image = UIImage(named: "sticker\(index)")
            $0.frame.size = CGSize(width: 100, height: 100)
            $0.center = view.center
            $0.contentMode = .scaleAspectFit
            $0.isUserInteractionEnabled = true
        }
        
        view.addSubview(stickerImageView)
        view.clipsToBounds = true
        
        setupGestureRecognizer(to: stickerImageView)
    }
    
    private func setupGestureRecognizer(to attachingView: UIView) {
        let panGestureRecognizer = UIPanGestureRecognizer().then {
            $0.delaysTouchesBegan = false
            $0.delaysTouchesEnded = false
            $0.delegate = self
            attachingView.addGestureRecognizer($0)
        }
        
        let pinchGestureRecognizer = UIPinchGestureRecognizer().then {
            $0.delegate = self
            attachingView.addGestureRecognizer($0)
        }
        
        let rotationGestureRecognizer = UIRotationGestureRecognizer().then {
            $0.delegate = self
            attachingView.addGestureRecognizer($0)
        }
        
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
        let translation = gestureRecognizer.translation(in: view)
        guard let gestureView = gestureRecognizer.view else {
            return
        }
        gestureView.center = CGPoint( x: gestureView.center.x + translation.x, y : gestureView.center.y + translation.y)
        gestureRecognizer.setTranslation(.zero, in: view)
    }
    
    private func handlePinchGesture(_ gestureRecognizer: UIPinchGestureRecognizer) {
        guard let gestureView = gestureRecognizer.view else {
            return
        }
        gestureView.transform = gestureView.transform.scaledBy(x: gestureRecognizer.scale, y:gestureRecognizer.scale)
        gestureRecognizer.scale = 1
    }
    
    private func handleRotationGesture(_ gestureRecognizer: UIRotationGestureRecognizer) {
        guard let gestureView = gestureRecognizer.view else { return }
        gestureView.transform = gestureView.transform.rotated(by: gestureRecognizer.rotation)
        gestureRecognizer.rotation = 0
    }
}

// MARK: UIGestureRecognizerDelegate
extension PreviewViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith shouldRecognizeSimultaneouslyWithGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
