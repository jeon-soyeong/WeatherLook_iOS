//
//  WeatherAPI.swift
//  WeatherLook_iOS
//
//  Created by 전소영 on 2022/03/03.
//

import Foundation

import Moya

enum WeatherAPI {
    case getWeatherData(latitude: Double, longitude: Double)
}

extension WeatherAPI: TargetType {
    var baseURL: URL {
        switch self {
        case .getWeatherData:
            return URL(string: APIConstants.baseUrl)!
        }
    }
    
    var path: String {
        switch self {
        case .getWeatherData:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getWeatherData:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getWeatherData(let latitude, let longitude):
            let parameters = ["lat": latitude, "lon": longitude, "lang": "kr", "exclude": "minutely" ,"appid": APIConstants.appId, "units": "metric"] as [String : Any]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .getWeatherData:
            return ["Content-Type": "application/json"]
        }
    }
}
