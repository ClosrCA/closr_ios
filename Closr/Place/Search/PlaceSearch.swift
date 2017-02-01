//
//  PlaceSearch.swift
//  Closr
//
//  Created by Tao on 2017-01-29.
//  Copyright © 2017 closr. All rights reserved.
//

import Foundation
import CoreLocation

typealias PlaceHandler = (([Place]?, Error?) -> Void)

protocol Place {
    var placeID: String! {get set}
    var name: String! {get set}
    var address: String! {get set}
    var rating: Double? {get set}
    var photos: [Photo]? {get set}
}

protocol Photo {
    var height: Double? {get set}
    var width: Double? {get set}
    var reference: String? {get set}
}

protocol PlaceSearch {
    var searchRequest: PlaceSearchRequest {get set}
    
    func placeNearby(completion: PlaceHandler?)
    func nextPage(completion: PlaceHandler?)
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
