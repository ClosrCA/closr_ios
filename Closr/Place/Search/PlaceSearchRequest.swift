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
    
    enum PlaceType: String {
        case restaurant = "restaurant"
        case food       = "food"
        case parking    = "parking"
    }
    
    var center: CLLocationCoordinate2D  = kCLLocationCoordinate2DInvalid
    var radius: CLLocationDistance      = CLLocationDistanceMax
    var type: String                    = ""
    var keyword: String                 = ""
    
    init(center: CLLocationCoordinate2D, radius: CLLocationDistance, type: PlaceType, keyword: String = "") {
        self.center     = center
        self.radius     = radius
        self.type       = type.rawValue
        self.keyword    = keyword
    }
}
