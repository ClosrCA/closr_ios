//
//  Location.swift
//  Closr
//
//  Created by Tao on 2017-02-22.
//  Copyright © 2017 closr. All rights reserved.
//

import CoreLocation

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

