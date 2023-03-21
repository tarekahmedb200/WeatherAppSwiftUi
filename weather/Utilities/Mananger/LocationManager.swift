//
//  LocationManager.swift
//  WeatherApp
//
//  Created by lapshop on 3/11/23.
//

import Foundation
import CoreLocation
import Combine

class LocationManager : NSObject {
    var locationManager = CLLocationManager()
    private var publish = PassthroughSubject<CLLocation,Never>()
    
    var observable : AnyPublisher<CLLocation,Never> {
        return publish
            .eraseToAnyPublisher()
    }
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        publish.send(location)
        publish.send(completion: .finished)
    }
}
