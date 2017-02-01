//
//  GooglePlaceSearch.swift
//  Closr
//
//  Created by Tao on 2017-01-26.
//  Copyright © 2017 closr. All rights reserved.
//

import CoreLocation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

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
    
    struct PlaceType {
        static let restaurant = "restaurant"
        static let parking    = "parking"
    }
    
    static func authenticate(params: [String: Any]) -> [String: Any] {
        var newParams = params
        newParams["key"] = key
        
        return newParams
    }
}

class GooglePlaceSearch: PlaceSearch {
    
    var searchRequest: PlaceSearchRequest
    
    init(searchRequest: PlaceSearchRequest) {
        self.searchRequest = searchRequest
    }
    
    fileprivate var places: [GoolgePlace] {
        
        return placesResults.reduce([GoolgePlace](), { (result, placesResult) -> [GoolgePlace] in
            
            var mutableResult = result
            
            if let places = placesResult.places {
                mutableResult.append(contentsOf: places)
            }
            
            return mutableResult
        })
    }
    
    fileprivate class PlacesResult: Mappable {
        var pagetoken: String?
        var places: [GoolgePlace]?
        
        required init?(map: Map) {
            
        }
        
        func mapping(map: Map) {
            pagetoken <- map["next_page_token"]
            places    <- map["results"]
        }
    }
    
    fileprivate lazy var placesResults = [PlacesResult]()
    fileprivate var isFetchingNextPage = false
    fileprivate var lastTimeSearchURL: String?
    
    func nextPage(completion: PlaceHandler?) {
        
        if isFetchingNextPage {
            return
        }
        
        guard let URL = lastTimeSearchURL else {
            return
        }
        
        guard let pagetoken = placesResults.last?.pagetoken else {
            return
        }
        
        isFetchingNextPage = true
        
        let params = GoogleAPI.authenticate(params: ["pagetoken": pagetoken])
        
        Alamofire.request(URL, parameters: params).responseObject { (response: DataResponse<PlacesResult>) in
            
            self.isFetchingNextPage = false
            
            self.handle(response: response, completion: completion)
        }
    }
    
    func placeNearby(completion: PlaceHandler?) {
        
        var params: [String: Any] = GoogleAPI.authenticate(params:["location": searchRequest.center.description,
                                                                   "radius": searchRequest.radius,
                                                                   "type": searchRequest.type])
        
        if let keyword = searchRequest.keyword {
            params["keyword"] = keyword
        }
        
        placesResults.removeAll()
        
        lastTimeSearchURL = GoogleAPI.PlaceURL.nearby
        
        Alamofire.request(GoogleAPI.PlaceURL.nearby, parameters: params).responseObject { (response: DataResponse<PlacesResult>) in
            
            self.handle(response: response, completion: completion)
        }
    }
    
    fileprivate func handle(response: DataResponse<PlacesResult>, completion: PlaceHandler?) {
        
        switch response.result {
            
        case .success(let value):
            
            placesResults.append(value)
            
            completion?(places, nil)
            
        case .failure(let error):
            
            completion?(nil, error)
        }
    }
}
