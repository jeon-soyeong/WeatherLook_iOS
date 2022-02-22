//
//  UIFont+Extension.swift
//  WeatherLook_iOS
//
//  Created by 전소영 on 2022/02/15.
//

import Foundation
import UIKit

enum FontType {
    case bold, semiBold, medium, regular
}

extension UIFont {
    static func setFont(type: FontType, size: CGFloat) -> UIFont {
        var fontName = ""
        
        switch type {
        case .bold:
            fontName = "AppleSDGothicNeo-Bold"
        case .semiBold:
            fontName = "AppleSDGothicNeo-SemiBold"
        case .medium:
            fontName = "AppleSDGothicNeo-Medium"
        case .regular:
            fontName = "AppleSDGothicNeo-Regular"
        }
        
        return UIFont(name: fontName, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
