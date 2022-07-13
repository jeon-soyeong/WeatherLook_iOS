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
    var completion: ((Int) -> Void)?
    
    private let stickerPopUpCollectionViewFlowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .vertical
        $0.minimumLineSpacing = .zero
        $0.minimumInteritemSpacing = .zero
    }
    
    private lazy var stickerPopUpCollectionView = UICollectionView.init(frame: .zero, collectionViewLayout: stickerPopUpCollectionViewFlowLayout).then {
        $0.showsVerticalScrollIndicator = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupSheetPresentationController()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        
        setupSubViews()
        setupCollectionView()
        setupConstraints()
    }
    
    private func setupSubViews() {
        view.addSubview(stickerPopUpCollectionView)
    }
    
    private func setupConstraints() {
        stickerPopUpCollectionView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalToSuperview().offset(24)
        }
    }
    
    private func setupCollectionView() {
        stickerPopUpCollectionView.dataSource = self
        stickerPopUpCollectionView.delegate = self
        stickerPopUpCollectionView.registerCell(cellType: StickerPopUpCollectionViewCell.self)
    }
    
    private func setupSheetPresentationController() {
        if let sheet = sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 15
            sheet.animateChanges {
                sheet.selectedDetentIdentifier = .medium
            }
        }
    }
}

// MARK: UICollectionViewDataSource
extension StickerPopUpViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 21
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let stickerPopUpCollectionViewCell = collectionView.dequeueReusableCell(cellType: StickerPopUpCollectionViewCell.self, indexPath: indexPath) else {
            return UICollectionViewCell()
        }
        stickerPopUpCollectionViewCell.setupUI(index: indexPath.item)
        
        return stickerPopUpCollectionViewCell
    }
}

// MARK: UICollectionViewDelegate
extension StickerPopUpViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        completion?(indexPath.row)
        coordinator?.popStickerPopUpViewController()
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension StickerPopUpViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Int(collectionView.frame.width) / 3, height: StickerPopUpCollectionViewCell.cellHeight)
    }
}
