//
//  Location.swift
//  Closr
//
//  Created by Tao on 2017-02-22.
//  Copyright © 2017 closr. All rights reserved.
//

import CoreLocation

class Location: NSObject {
    
    fileprivate lazy var locationManager: CLLocationManager = CLLocationManager()
    
    fileprivate var completion: ((CLLocation, Error?) -> Void)?
    
    override init() {
        super.init()
        
        locationManager.delegate        = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestWhenInUseAuthorization()
    }
    
    func getCurrentLocation(completion: ((CLLocation, Error?) -> Void)?) {
        locationManager.startUpdatingLocation()
        
        self.completion = completion
    }
}

extension Location: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last, location.horizontalAccuracy < 100 {
            
            completion?(location, nil)
            
            manager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        completion?(CLLocation(latitude: CLLocationCoordinate2D.downtownToronto.latitude, longitude: CLLocationCoordinate2D.downtownToronto.longitude), error)
    }
}

extension CLLocationDistance {
    static let defaultRadius: CLLocationDistance = 2000.0
    static let shortDistance: CLLocationDistance = 500.0
    static let longDistance: CLLocationDistance  = 20000.0
    
    var readableDescription: String {
        return String(format: "%.01f km", self / 1000)
    }
}

extension CLLocationCoordinate2D {
    
    static let downtownToronto = CLLocationCoordinate2D(latitude: 43.6427431, longitude: -79.3762986)
}

extension CLLocationCoordinate2D: CustomStringConvertible {
    public var description: String {
        return "\(latitude),\(longitude)"
    }
}

