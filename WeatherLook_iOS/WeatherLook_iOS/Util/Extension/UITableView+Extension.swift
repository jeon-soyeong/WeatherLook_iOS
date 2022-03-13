//
//  UITableView+Extension.swift
//  WeatherLook_iOS
//
//  Created by 전소영 on 2022/03/07.
//

import Foundation
import UIKit

extension UITableView {
    func registerCell<T: UITableViewCell>(cellType: T.Type) {
        let identifier = String(describing: T.self)
        self.register(cellType, forCellReuseIdentifier: identifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(cellType: T.Type, indexPath: IndexPath) -> T? {
        let identifier = String(describing: cellType)
        return dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T
    }
}
