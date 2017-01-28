//
//  Shared.swift
//  Closr
//
//  Created by Tao on 2017-01-26.
//  Copyright © 2017 closr. All rights reserved.
//

import CoreLocation

struct GoogleAPI {
    static let key = "AIzaSyBCix_8uz7Joe5BfeKLDKPBmpc1wd-G98k"
    
    struct PlaceURL {
        // param: location=-33.8670522,151.1957362&radius=500&type=restaurant&keyword=cruise&key=YOUR_API_KEY
        static let nearby       = "https://maps.googleapis.com/maps/api/place/nearbysearch/json"
        // param: query=123+main+street&key=YOUR_API_KEY
        static let textSearch   = "https://maps.googleapis.com/maps/api/place/textsearch/json"
        // param: placeid or reference
        static let detail       = "https://maps.googleapis.com/maps/api/place/details/json"
        // param: maxwidth=400&photoreference=3FyhNLlBU&key=YOUR_API_KEY
        static let photo        = "https://maps.googleapis.com/maps/api/place/photo"
    }
    
    enum PlaceType: String {
        case restaurant = "restaurant"
        case parking    = "parking"
    }
    
    static func authenticate(params: [String: Any]) -> [String: Any] {
        var newParams = params
        newParams["key"] = key
        
        return newParams
    }
}

extension CLLocationCoordinate2D {
    
    static let defaultRadius: CLLocationDistance = 2000.0
    
    static let downtownToronto = CLLocationCoordinate2D(latitude: 43.6427431, longitude: -79.3762986)
}

extension CLLocationCoordinate2D: CustomStringConvertible {
    public var description: String {
        return "\(latitude),\(longitude)"
    }
}
