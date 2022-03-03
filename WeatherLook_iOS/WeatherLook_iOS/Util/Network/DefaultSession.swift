//
//  DefaultSession.swift
//  WeatherLook_iOS
//
//  Created by 전소영 on 2022/03/03.
//

import Foundation

import Moya

class DefaultSession: Session {
    static let sharedSession: DefaultSession = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Session.default.session.configuration.httpAdditionalHeaders
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 50
        configuration.requestCachePolicy = .useProtocolCachePolicy
        return DefaultSession(configuration: configuration)
    }()
}
