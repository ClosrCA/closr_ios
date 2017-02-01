//
//  PlaceSearch.swift
//  Closr
//
//  Created by Tao on 2017-01-26.
//  Copyright © 2017 closr. All rights reserved.
//

import CoreLocation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

typealias PlaceHandler = (([Place]?, Error?) -> Void)

class PlaceSearch {
    
    var places: [Place] {
        
        return placesResults.reduce([Place](), { (result, placesResult) -> [Place] in
            
            var mutableResult = result
            
            if let places = placesResult.places {
                mutableResult.append(contentsOf: places)
            }
            
            return mutableResult
        })
    }
    
    fileprivate class PlacesResult: Mappable {
        var pagetoken: String?
        var places: [Place]?
        
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
    
    func placeNearby(location: CLLocationCoordinate2D, within radius: CLLocationDistance = 5000, type: GoogleAPI.PlaceType, keyword: String? = nil, completion: PlaceHandler?) {
        
        var params: [String: Any] = GoogleAPI.authenticate(params:["location": location.description,
                                                                   "radius": radius,
                                                                   "type": type.rawValue])
        
        if let keyword = keyword {
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
