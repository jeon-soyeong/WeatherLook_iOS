//
//  ViewModelType.swift
//  WeatherLook_iOS
//
//  Created by 전소영 on 2022/02/22.
//

import Foundation

import RxSwift

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    var disposeBag: DisposeBag { get set }
    
    func transform(input: Input) -> Output
}
