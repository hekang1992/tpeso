//
//  LocationConfig.swift
//  Tpeso
//
//  Created by tom on 2025/5/26.
//

import UIKit
import CoreLocation
import RxSwift
import RxRelay

class LocationModel {
    var sleepy_owl: String = ""
    var noisy_cat: String = ""
    var angry_bee: String = ""
    var hungry_ant: String = ""
    var close_lid: Double = 0.0
    var clean_hand: Double = 0.0
    var tiny_fish: String = ""
    var fresh_snow: String = ""
    var treeship: String = ""
}

class LocationManager: NSObject {
    
    var completion: ((LocationModel) -> Void)?
    
    var model = BehaviorRelay<LocationModel?>(value: nil)
    
    let disposeBag = DisposeBag()
    
    var locationMan = CLLocationManager()
    
    override init() {
        super.init()
        locationMan.delegate = self
        locationMan.desiredAccuracy = kCLLocationAccuracyBest
        model.asObservable()
            .debounce(RxTimeInterval.milliseconds(500),
                       scheduler: MainScheduler.instance)
           .subscribe(onNext: { locationModel in
                if let locationModel = locationModel {
                    self.completion?(locationModel)
                }
            }).disposed(by: disposeBag)
        
    }
    
}

extension LocationManager: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            locationMan.startUpdatingLocation()
        case .denied, .restricted:
            let model = LocationModel()
            self.model.accept(model)
            locationMan.stopUpdatingLocation()
        default:
            break
        }
    }
    
    func getLocationInfo(completion: @escaping (LocationModel) -> Void) {
        self.completion = completion
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            let status: CLAuthorizationStatus
            if #available(iOS 14.0, *) {
                status = CLLocationManager().authorizationStatus
            } else {
                status = CLLocationManager.authorizationStatus()
            }
            if status == .notDetermined {
                locationMan.requestAlwaysAuthorization()
                locationMan.requestWhenInUseAuthorization()
            }else if status == .restricted || status == .denied {
                let model = LocationModel()
                self.model.accept(model)
            }else {
                locationMan.startUpdatingLocation()
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let model = LocationModel()
        model.clean_hand = location.coordinate.longitude
        model.close_lid = location.coordinate.latitude
        let geocoder = CLGeocoder()
        let lion = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        geocoder.reverseGeocodeLocation(lion) { [weak self] placemarks, error in
            guard let self = self else { return }
            if let error = error {
                return
            }
            guard let placemark = placemarks?.first else {
                return
            }
            self.onModel(model, with: placemark)
            self.model.accept(model)
            self.locationMan.stopUpdatingLocation()
        }
    }

    private func onModel(_ model: LocationModel, with placemark: CLPlacemark) {
        let countryCode = placemark.isoCountryCode ?? ""
        let country = placemark.country ?? ""
        var provice = placemark.administrativeArea ?? ""
        let city = placemark.locality ?? ""
        let street = (placemark.subLocality ?? "") + (placemark.thoroughfare ?? "")
        if provice.isEmpty {
            provice = city
        }
        model.sleepy_owl = provice
        model.noisy_cat = countryCode
        model.angry_bee = country
        model.hungry_ant = street
        model.tiny_fish = city
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
    
}
