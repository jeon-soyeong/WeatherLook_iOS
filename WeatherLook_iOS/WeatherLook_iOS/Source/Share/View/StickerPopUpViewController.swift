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
    
    private let backgroundView = UIView().then {
        $0.backgroundColor = .transparentGrey
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        setupSubViews()
        setupConstraints()
    }
    
    private func setupSubViews() {
        view.addSubview(backgroundView)
    }
    
    private func setupConstraints() {
        backgroundView.snp.makeConstraints {
            $0.centerX.centerY.width.height.equalToSuperview()
        }
    }
}
