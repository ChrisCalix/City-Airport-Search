//
//  LocationService.swift
//  City Airport Search
//
//  Created by Sonic on 19/5/23.
//

import Foundation
import CoreLocation
import RxRelay
import RxSwift

final class LocationService: NSObject {
    
    static let shared: LocationService = LocationService()
    private let manager = CLLocationManager()
    
    private let currentLocationRelay: BehaviorRelay<(lat: Double, lon: Double)?> = BehaviorRelay(value: nil)
    lazy var currentLocation: Observable<(lat: Double, lon: Double)?> = self.currentLocationRelay.asObservable().share(replay: 1, scope: .forever)
    
    private override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        manager.requestAlwaysAuthorization()
    }
    
    deinit {
        manager.stopUpdatingLocation()
    }
}

extension LocationService: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse || manager.authorizationStatus == .authorizedAlways {
            manager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let currentLocation = (
                lat: location.coordinate.latitude,
                lon: location.coordinate.longitude
            )
            currentLocationRelay.accept(currentLocation)
        }
        manager.stopUpdatingLocation()
    }
}


extension LocationService {
    
    static func getDistance(
        airportLocation: (lat: Double?, lon: Double?),
        currentLocation: (lat: Double, lon: Double)) -> Double? {
            guard let airpotLat = airportLocation.lat, let airportLon = airportLocation.lon  else { return nil }
            let current = CLLocation(latitude: currentLocation.lat, longitude: currentLocation.lon)
            let airport = CLLocation(latitude: airpotLat, longitude: airportLon)
            return current.distance(from: airport)
        }
}
