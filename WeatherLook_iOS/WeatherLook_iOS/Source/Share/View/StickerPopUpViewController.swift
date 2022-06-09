//
//  StickerPopUpViewController.swift
//  WeatherLook_iOS
//
//  Created by 전소영 on 2022/06/08.
//

import UIKit

import RxSwift
import SnapKit

class StickerPopUpViewController: UIViewController {
    weak var coordinator: StickerPopUpCoordinator?
    private let disposeBag = DisposeBag()
    
    private let stickerPopUpViewHeight: CGFloat = 400
    private var stickerPopUpViewMinimumTopConstant: CGFloat = 50
    private var stickerPopUpViewTopConstraint: Constraint!
    private lazy var stickerPopUpViewStartTopConstant: CGFloat = stickerPopUpViewMinimumTopConstant
    private lazy var safeAreaHeight: CGFloat = view.safeAreaLayoutGuide.layoutFrame.height
    private lazy var safeAreaInsetBottomHeight: CGFloat = view.safeAreaInsets.bottom
    private lazy var defaultTopConstant: CGFloat = safeAreaHeight + safeAreaInsetBottomHeight - stickerPopUpViewHeight
    
    private let backgroundView = UIView().then {
        $0.backgroundColor = .transparentGrey
    }
    
    private let stickerPopUpView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.clipsToBounds = true
    }
    
    private let indicatorView = UIView().then {
        $0.backgroundColor = .lightGray
        $0.layer.cornerRadius = 3
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
        view.addSubview(indicatorView)
    }
    
    private func setupConstraints() {
        backgroundView.snp.makeConstraints {
            $0.centerX.centerY.width.height.equalToSuperview()
        }
        
        stickerPopUpView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            let topConstant = safeAreaHeight + safeAreaInsetBottomHeight
            $0.top.equalTo(topConstant)
            stickerPopUpViewTopConstraint = $0.top.equalTo(topConstant).constraint
        }
    
        indicatorView.snp.makeConstraints {
            $0.width.equalTo(60)
            $0.height.equalTo(7)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(stickerPopUpView.snp.top).inset(12)
        }
    }
    
    private func setupGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
        backgroundView.addGestureRecognizer(tapGestureRecognizer)
        backgroundView.isUserInteractionEnabled = true
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        panGestureRecognizer.delaysTouchesBegan = false
        panGestureRecognizer.delaysTouchesEnded = false
        view.addGestureRecognizer(panGestureRecognizer)
    }
    
    @objc private func handleTapGesture(_ gestureRecognizer: UITapGestureRecognizer) {
        hideStickerPopUpView()
    }
    
    @objc private func handlePanGesture(_ gestureRecognizer: UIPanGestureRecognizer) {
        let translation = gestureRecognizer.translation(in: view)
        let velocity = gestureRecognizer.velocity(in: view)
        let stickerPopUpViewTopConstant = stickerPopUpViewTopConstraint.layoutConstraints.first?.constant ?? 0
        
        switch gestureRecognizer.state {
        case .began:
            if defaultTopConstant < stickerPopUpViewTopConstant {
                stickerPopUpView.snp.updateConstraints {
                    $0.top.equalTo(defaultTopConstant)
                    stickerPopUpViewTopConstraint = $0.top.equalTo(defaultTopConstant).constraint
                }
            }
            stickerPopUpViewStartTopConstant = stickerPopUpViewTopConstant
        case .changed:
            if stickerPopUpViewStartTopConstant + translation.y > stickerPopUpViewMinimumTopConstant {
                stickerPopUpView.snp.updateConstraints {
                    $0.top.equalTo(stickerPopUpViewStartTopConstant + translation.y)
                    stickerPopUpViewTopConstraint = $0.top.equalTo(stickerPopUpViewStartTopConstant + translation.y).constraint
                }
            }
        case .ended:
            if velocity.y > 1500 {
                hideStickerPopUpView()
                return
            }
            
            if stickerPopUpViewTopConstant < (safeAreaHeight + safeAreaInsetBottomHeight) * 0.45 {
                showStickerPopUpView(atState: .expanded)
            } else if stickerPopUpViewTopConstant < safeAreaHeight - 150 {
                showStickerPopUpView(atState: .normal)
            } else {
                hideStickerPopUpView()
            }
        default:
            break
        }
    }
    
    private func showStickerPopUpView(atState: StickerPopUpViewState = .normal) {
        if atState == .normal {
            stickerPopUpView.snp.updateConstraints {
                $0.top.equalTo(defaultTopConstant)
            }
        } else {
            stickerPopUpView.snp.updateConstraints {
                $0.top.equalTo(stickerPopUpViewMinimumTopConstant)
            }
        }
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.backgroundView.alpha = 0.5
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func hideStickerPopUpView() {
        stickerPopUpView.snp.updateConstraints {
            $0.top.equalTo(safeAreaHeight + safeAreaInsetBottomHeight)
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
