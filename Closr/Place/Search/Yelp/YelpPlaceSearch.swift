//
//  YelpPlaceSearch.swift
//  Closr
//
//  Created by Tao on 2017-01-29.
//  Copyright © 2017 closr. All rights reserved.
//

import Foundation
import CoreLocation

class YelpPlaceSearch {
    
    fileprivate struct Field {
        static let term = "term"
        static let offset = "offset"
        static let location = "location"    //location=San Francisco
        static let latitude = "latitude"
        static let longitude = "longitude"
        static let radius = "radius"
        static let category = "categories"
        static let sortBy = "sort_by"
        static let priceFilter = "price"
    }
    
    var searchRequest: PlaceSearchRequest
    
    var places = [YelpPlace]()
    
    fileprivate var isFetching = false
    fileprivate var lastTimeSearchURL: String?
    fileprivate var total: Int = 0
    
    class func foodSearch(with location: CLLocation) -> YelpPlaceSearch {
        
        let searchRequest = PlaceSearchRequest(center: location.coordinate, radius: CLLocationDistance.defaultRadius, type: .food)
        
        return YelpPlaceSearch(searchRequest: searchRequest)
    }
    
    init(searchRequest: PlaceSearchRequest) {
        self.searchRequest = searchRequest
    }
    
    func fetchPlaces(completion: PlacesHandler?) {
        
        if isFetching {
            return
        }
        
        places.removeAll()
        
        placesBySearch(withOffset: 0, completion: completion)
    }
    
    func nextPage(completion: PlacesHandler?) {
        
        if isFetching {
            return
        }
        
        if total <= places.count {
            return
        }
        
        placesBySearch(withOffset: places.count, completion: completion)
    }
    
    func fetch(placeID: String, completion: PlaceDetailHandler?) {
        YelpAPI.getPlaceDetail(placeID: placeID, onSuccess: { (place) in
            completion?(place, nil)
        }) { (error) in
            completion?(nil, error)
        }
    }
    
    fileprivate func placesBySearch(withOffset offset: Int, completion: PlacesHandler?) {
        var params: [String: Any] = [Field.offset: offset]
        
        if !searchRequest.type.isEmpty {
            params[Field.category] = searchRequest.type
        }
        
        if CLLocationCoordinate2DIsValid(searchRequest.center) {
            params[Field.latitude] = searchRequest.center.latitude
            params[Field.longitude] = searchRequest.center.longitude
        }
        
        if searchRequest.radius != CLLocationDistanceMax {
            params[Field.radius] = searchRequest.radius
        }
        
        if !searchRequest.keyword.isEmpty {
            params[Field.term] = searchRequest.keyword
        }
        
        isFetching = true
        YelpAPI.getPlaceList(parameters: params, onSuccess: { (places, total) in
            self.isFetching = false
            self.total = total
            self.places.append(contentsOf: places)
            completion?(places, nil)
        }) { (errorString) in
            self.isFetching = false
            completion?(self.places, errorString)
        }
    }
}
