//
//  YelpPlace.swift
//  Closr
//
//  Created by Tao on 2017-01-29.
//  Copyright © 2017 closr. All rights reserved.
//

import Foundation
import CoreLocation
import ObjectMapper

class YelpPlace: Place, Mappable {
    var placeID: String!
    var name: String!
    var address: String! {
        set {
            
        }
        get {
            return location?.displayAddress?.joined(separator: ",\n")
        }
    }
    
    var rating: Double?
    var photos: [Photo]?
    
    var imageURL: String?
    var snippetImageURL: String?
    var location: YelpLocation?
    var isClosed: Bool = false
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        placeID <- map["id"]
        name <- map["name"]
        imageURL <- map["image_url"]
        snippetImageURL <- map["snippet_image_url"]
        location <- map["location"]
        isClosed <- map["is_closed"]
        rating <- map["rating"]
    }
    
}

class YelpLocation: Mappable {
    var crossStreets: String?
    var city: String?
    var displayAddress: [String]?
    var coordinate: CLLocationCoordinate2D?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        crossStreets <- map["cross_streets"]
        city <- map["city"]
        displayAddress <- map["display_address"]
        coordinate <- map["coordinate"]
    }
}

extension CLLocationCoordinate2D: Mappable {
    
    public init?(map: Map) {
        latitude = 0.0
        longitude = 0.0
    }
    
    mutating public func mapping(map: Map) {
        latitude <- map["latitude"]
        longitude <- map["longitude"]
    }
}
