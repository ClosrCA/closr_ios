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

typealias PlacesHandler = (([YelpPlace]?, Error?) -> Void)
typealias PlaceDetailHandler = ((YelpPlace?, Error?) -> Void)

struct YelpPlace: Mappable {
    var placeID: String!
    var name: String!
    var rating: Double?
    var price: String?
    var isClosed: Bool = false
    var imageURL: String?
    var address: Address?
    var distance: CLLocationDistance?
    var coordinates: CLLocationCoordinate2D?
    
    var phone: String?
    var photos: [String]?
    var categories: [Category]?
    var hours: [OpenHours]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        placeID     <- map["id"]
        name        <- map["name"]
        rating      <- map["rating"]
        price       <- map["price"]
        isClosed    <- map["is_closed"]
        imageURL    <- map["image_url"]
        address     <- map["location"]
        distance    <- map["distance"]
        coordinates <- map["coordinates"]
        phone       <- map["display_phone"]
        photos      <- map["photos"]
        categories  <- map["categories"]
        hours       <- map["hours"]
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

struct Category: Mappable {
    var alias: String?
    var title: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        alias  <- map["alias"]
        title  <- map["title"]
    }
}

struct OpenHours: Mappable {
    var isOpenNow: Bool = false
    var hoursType: String = "REGULAR"
    var hours: [Hours]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        isOpenNow <- map["is_open_now"]
        hours     <- map["open"]
        hoursType <- map["hours_type"]
    }
    
    struct Hours: Mappable {
        var day: Int = 0
        var endTime: String = ""  // "2300"
        var startTime: String = ""
        var isOvernight: Bool = false
        
        init?(map: Map) {
            
        }
        
        mutating func mapping(map: Map) {
            day             <- map["day"]
            endTime         <- map["end"]
            startTime       <- map["start"]
            isOvernight     <- map["is_overnight"]
        }
    }
}

extension OpenHours {
    var readableHours: [String: (startTime: String, endTime: String)] {
        
        guard let hours = hours, !hours.isEmpty else {
            return [:]
        }
        
        var hoursDictionary = [String: (startTime: String, endTime: String)]()
        
        hours.forEach { hoursDictionary[weekdaySring($0.day)] = (formattedTime($0.startTime), formattedTime($0.endTime)) }
        
        return hoursDictionary
    }
    
    func weekdaySring(_ weekday: Int) -> String {
        switch weekday {
        case 0:
            return "Mon"
        case 1:
            return "Tue"
        case 2:
            return "Wed"
        case 3:
            return "Thu"
        case 4:
            return "Fri"
        case 5:
            return "Sat"
        default:
            return "Sun"
        }
    }
    
    func formattedTime(_ rawString: String) -> String {
        var mutableString = rawString
        
        mutableString.insert(":", at: mutableString.index(mutableString.startIndex, offsetBy: 2))
        
        return mutableString
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
