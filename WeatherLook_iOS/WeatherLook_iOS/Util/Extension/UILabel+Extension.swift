//
//  UILabel+Extension.swift
//  WeatherLook_iOS
//
//  Created by 전소영 on 2022/03/11.
//

import Foundation
import UIKit

extension UILabel {
   func setHighlight(_ text: String, with search: String) {
       let attributedText = NSMutableAttributedString(string: text)
       let range = NSString(string: text).range(of: search, options: .caseInsensitive)
       let highlightFont = UIFont.systemFont(ofSize: 16)
       let highlightColor = UIColor.white
       let highlightedAttributes: [NSAttributedString.Key: Any] = [ NSAttributedString.Key.font: highlightFont, NSAttributedString.Key.foregroundColor: highlightColor]
       
       attributedText.addAttributes(highlightedAttributes, range: range)
       self.attributedText = attributedText
   }
}
