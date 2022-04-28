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

    func request<T: Codable, API: TargetType>(_ target: API) -> Single<T> {
        return Single<T>.create { single in
            let provider = MoyaProvider<API>(session: DefaultSession.sharedSession)
            let request = provider.request(target) { result in
                switch result {
                case .success(let response):
                    do {
                        let parsedResponse = try JSONDecoder().decode(T.self, from: response.data)
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
    
    func testRequest<C: Codable, T: TargetType>(target: T, responseType: C.Type, completion: @escaping (Result<C, APIError>) -> Void) {
        let provider = MoyaProvider<T>(session: DefaultSession.sharedSession)
        
        provider.request(target) { result in
            switch result {
            case .success(let response):
                if 400..<500 ~= response.statusCode {
                    completion(.failure(.clientError))
                    print("clientError")
                } else if 500..<600 ~= response.statusCode {
                    completion(.failure(.serverError))
                    print("serverError")
                }
                do {
                    let parsedResponse = try JSONDecoder().decode(responseType, from: response.data)
                    completion(.success(parsedResponse))
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(.networkError))
                print("networkError")
            }
        }
    }
}


enum APIError: Error {
    case clientError
    case serverError
    case networkError
}
