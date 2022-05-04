//
//  APIService.swift
//  WeatherLook_iOS
//
//  Created by 전소영 on 2022/03/03.
//

import Foundation

import Moya
import RxSwift

class APIService {
    static let shared = APIService()
    
    func request<T: Codable, API: TargetType>(_ target: API, _ responseType: T.Type) -> Single<T> {
        return Single<T>.create { single in
            let provider = MoyaProvider<API>(session: DefaultSession.sharedSession)
            let request = provider.request(target) { result in
                switch result {
                case .success(let response):
                    do {
                        let parsedResponse = try JSONDecoder().decode(responseType, from: response.data)
                        single(.success(parsedResponse))
                    } catch let error {
                        single(.failure(error))
                    }
                case .failure(let error):
                    single(.failure(error))
                }
            }

            return Disposables.create { request.cancel() }
        }
    }
}
