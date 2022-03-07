//
//  UserDefaultsManager.swift
//  WeatherLook_iOS
//
//  Created by 전소영 on 2022/03/02.
//

import Foundation

struct UserDefaultsManager {
    @UserDefaultWrapper(key: "locationList", defaultValue: nil)
    static var locationList: [Location]?
}
