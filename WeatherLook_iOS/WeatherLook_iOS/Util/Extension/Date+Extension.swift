//
//  Date+Extension.swift
//  WeatherLook_iOS
//
//  Created by 전소영 on 2022/03/04.
//

import Foundation

extension Date {
    func convertToString(dateFormat format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.locale = Locale(identifier: "ko")
        
        return dateFormatter.string(from: self)
    }
}
