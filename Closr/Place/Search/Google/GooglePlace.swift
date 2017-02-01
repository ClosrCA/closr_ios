//
//  Place.swift
//  Closr
//
//  Created by Tao on 2017-01-25.
//  Copyright © 2017 closr. All rights reserved.
//

import ObjectMapper

class GoolgePlace: Place, Mappable, CustomStringConvertible {
    var placeID: String!
    var name: String!
    var address: String!
    var rating: Double?
    var photos: [Photo]? {
        set {
            googlePhotos = newValue as? [GooglePhoto]
        }
        get {
            return googlePhotos
        }
    }
    
    fileprivate var googlePhotos: [GooglePhoto]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        placeID <- map["place_id"]
        name    <- map["name"]
        address <- map["vicinity"]
        rating  <- map["rating"]
        googlePhotos  <- map["photos"]
    }
    
    var description: String {
        return "id: \(placeID), name: \(name), address: \(address), rating: \(rating)"
    }
}
