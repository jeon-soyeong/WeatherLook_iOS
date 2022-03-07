//
//  LocationManager.swift
//  WeatherLook_iOS
//
//  Created by 전소영 on 2022/03/01.
//

import Foundation

import RxSwift
import RxCocoa
import RxCoreLocation
import CoreLocation

class LocationManager {
    static let shared = LocationManager()
    
    let locationSubject = PublishSubject<CLLocationCoordinate2D>()
    let placeMarkSubject = PublishSubject<String>()
    private let disposeBag = DisposeBag()
    
    private let locationManager = CLLocationManager().then {
        $0.desiredAccuracy = kCLLocationAccuracyBest
        $0.distanceFilter = kCLDistanceFilterNone
    }
    
    private init() {
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.rx.didChangeAuthorization
            .subscribe(onNext: { _, status in
                switch status {
                case .denied:
                    print("Authorization denied")
                case .notDetermined:
                    self.locationManager.requestWhenInUseAuthorization()
                case .restricted:
                    print("Authorization: restricted")
                case .authorizedAlways, .authorizedWhenInUse:
                    self.locationManager.startUpdatingLocation()
                @unknown default:
                    print("Unknown case of status")
                }
            })
            .disposed(by: disposeBag)
        
        self.locationManager.rx.didUpdateLocations
            .compactMap(\.locations.last?.coordinate)
            .subscribe(onNext: self.locationSubject.onNext(_:))
            .disposed(by: disposeBag)
        
        self.locationManager.rx.placemark
            .subscribe(onNext: { placemark in
                guard let locality = placemark.locality, let subLocality = placemark.subLocality else {
                    return
                }
                self.placeMarkSubject.onNext("\(locality) \(subLocality)")
            })
            .disposed(by: disposeBag)
    }
}
