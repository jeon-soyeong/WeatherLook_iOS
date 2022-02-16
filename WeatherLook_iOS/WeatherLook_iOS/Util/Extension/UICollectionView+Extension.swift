//
//  UICollectionView+Extension.swift
//  WeatherLook_iOS
//
//  Created by 전소영 on 2022/02/15.
//

import Foundation
import UIKit

extension UICollectionView {
    func registerCell<T: UICollectionViewCell>(cellType: T.Type) {
        let identifier = String(describing: T.self)
        self.register(cellType, forCellWithReuseIdentifier: identifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(cellType: T.Type, indexPath: IndexPath) -> T? {
        let identifier = String(describing: cellType)
        return dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? T
    }
}
