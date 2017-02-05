//
//  PlaceSearchRequest.swift
//  Closr
//
//  Created by Tao on 2017-01-29.
//  Copyright © 2017 closr. All rights reserved.
//

import Foundation
import CoreLocation

class PlaceSearchRequest {
    var center: CLLocationCoordinate2D
    var radius: CLLocationDistance
    var type: String
    var keyword: String? 
    
    init(center: CLLocationCoordinate2D, radius: CLLocationDistance, type: String, keyword: String? = nil) {
        self.center     = center
        self.radius     = radius
        self.type       = type
        self.keyword    = keyword
    }
}

extension CLLocationDistance {
    static let defaultRadius: CLLocationDistance = 2000.0
    static let shortDistance: CLLocationDistance = 500.0
    static let longDistance: CLLocationDistance  = 20000.0
}

extension CLLocationCoordinate2D {
    
    static let downtownToronto = CLLocationCoordinate2D(latitude: 43.6427431, longitude: -79.3762986)
}

extension CLLocationCoordinate2D: CustomStringConvertible {
    public var description: String {
        return "\(latitude),\(longitude)"
    }
}
