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
    
    init(center: CLLocationCoordinate2D, radius: CLLocationDistance, type: String) {
        self.center = center
        self.radius = radius
        self.type   = type
    }
}
