//
//  Shared.swift
//  Closr
//
//  Created by Tao on 2017-01-26.
//  Copyright © 2017 closr. All rights reserved.
//

import CoreLocation

extension CLLocationCoordinate2D {
    static let downtownToronto = CLLocationCoordinate2D(latitude: 43.6427431, longitude: -79.3762986)
}

extension CLLocationCoordinate2D: CustomStringConvertible {
    public var description: String {
        return "\(latitude),\(longitude)"
    }
}
