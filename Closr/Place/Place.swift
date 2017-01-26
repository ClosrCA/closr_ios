//
//  Place.swift
//  Closr
//
//  Created by Tao on 2017-01-25.
//  Copyright © 2017 closr. All rights reserved.
//

import CoreLocation
import ObjectMapper
import AlamofireObjectMapper
import Alamofire

struct GoogleAPI {
    static let key = "AIzaSyBCix_8uz7Joe5BfeKLDKPBmpc1wd-G98k"
    
    struct PlaceURL {
        // param: location=-33.8670522,151.1957362&radius=500&type=restaurant&keyword=cruise&key=YOUR_API_KEY
        static let nearby   = "https://maps.googleapis.com/maps/api/place/nearbysearch/json"
        // param: query=123+main+street&key=YOUR_API_KEY
        static let search   = "https://maps.googleapis.com/maps/api/place/textsearch/json"
        // param: placeid or reference
        static let detail   = "https://maps.googleapis.com/maps/api/place/details/json"
        // param: maxwidth=400&photoreference=3FyhNLlBU&key=YOUR_API_KEY
        static let photo    = "https://maps.googleapis.com/maps/api/place/photo"
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

typealias PlaceHandler = (([Place]?, Error?) -> Void)

class PlacesResult: Mappable {
    var pagetoken: String?
    var places: [Place]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        pagetoken <- map["next_page_token"]
        places    <- map["results"]
    }
}

class Place: Mappable, CustomStringConvertible {
    var placeID: String!
    var name: String!
    var address: String!
    var rating: Double?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        placeID <- map["place_id"]
        name    <- map["name"]
        address <- map["vicinity"]
        rating  <- map["rating"]
    }
    
    var description: String {
        return "id: \(placeID), name: \(name), address: \(address), rating: \(rating)"
    }
}

extension Place {
    class func placeNearby(location: CLLocationCoordinate2D, within radius: CLLocationDistance = 2000, type: GoogleAPI.PlaceType, keyword: String? = nil, completion: PlaceHandler?) {
        
        let params: [String: Any] = GoogleAPI.authenticate(params:["location": location.description,
                                                                   "radius": radius,
                                                                   "type": type.rawValue])
        
        Alamofire.request(GoogleAPI.PlaceURL.nearby, parameters: params).responseObject { (response: DataResponse<PlacesResult>) in
            completion?(response.result.value?.places, response.result.error)
        }
    }
}

