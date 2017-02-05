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

typealias PlaceHandler = (([YelpPlace]?, Error?) -> Void)

class YelpPlace: Mappable {
    var placeID: String!
    var name: String!
    var rating: Double?
    var price: String?
    var isClosed: Bool = false
    var imageURL: String?
    var address: Address?
    var distance: CLLocationDistance?
    var coordinates: CLLocationCoordinate2D?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        placeID     <- map["id"]
        name        <- map["name"]
        rating      <- map["rating"]
        price       <- map["price"]
        isClosed    <- map["is_closed"]
        imageURL    <- map["image_url"]
        address     <- map["location"]
        distance    <- map["distance"]
        coordinates <- map["coordinates"]
    }
}

struct Address: Mappable {
    var displayAddress: [String]?
    var city: String?
    var state: String?
    var country: String?
    var zipCode: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        displayAddress  <- map["display_address"]
        city            <- map["city"]
        state           <- map["state"]
        country         <- map["country"]
        zipCode         <- map["zip_code"]
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
