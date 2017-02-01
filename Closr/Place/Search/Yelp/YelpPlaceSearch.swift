//
//  YelpPlaceSearch.swift
//  Closr
//
//  Created by Tao on 2017-01-29.
//  Copyright © 2017 closr. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper
import OAuthSwift
import SwiftyJSON

struct YelpAPI {
    static let consumerKey = "dUKt4i9SsihhbxrpDfEI-Q"
    static let consumerSecret = "cIsdlO0c1jwsFiROOqbvJssY4dw"
    static let token = "J3eFJqbKAgG6koKoQroDYevr54KeEXjo"
    static let tokenSecret = "tPUEWH4onUC16clby1b9zj1wFaQ"
    
    struct PlaceURL {
        static let search = "https://api.yelp.com/v2/search"
        static let detail = "https://api.yelp.com/v2/business/"
    }
    
    struct PlaceType {
        static let restaurant = "restaurant"
        static let food       = "food"
        static let parking    = "parking"
    }
    
    struct Field {
        static let term = "term"
        static let offset = "offset"
        static let location = "location"    //location=San Francisco
        static let coordinate = "location"       //cll=latitude,longitude
        static let radius = "radius_filter"
        static let category = "category"
    }
    
    struct OauthField {
        static let consumerKey  = "oauth_consumer_key"
        static let token        = "oauth_token"
        static let signatureMethod = "oauth_signature_method"
        static let timestamp    = "oauth_timestamp"
        static let nonce        = "oauth_nonce"
        static let signature    = "oauth_signature"
    }
}

class YelpPlaceSearch: PlaceSearch {
    
    var searchRequest: PlaceSearchRequest
    
    var places = [YelpPlace]()
    
    fileprivate var isFetching = false
    fileprivate var lastTimeSearchURL: String?
    fileprivate var total: Int = 0
    
    fileprivate lazy var oauthClient = OAuthSwiftClient(consumerKey: YelpAPI.consumerKey,
                                                        consumerSecret: YelpAPI.consumerSecret,
                                                        oauthToken: YelpAPI.token,
                                                        oauthTokenSecret: YelpAPI.tokenSecret,
                                                        version: .oauth1)
    
    init(searchRequest: PlaceSearchRequest) {
        self.searchRequest = searchRequest
    }
    
    func placeNearby(completion: PlaceHandler?) {
        
        if isFetching {
            return
        }
        
        places.removeAll()
        
        placeNearby(withOffset: 0, completion: completion)
    }
    
    func nextPage(completion: PlaceHandler?) {
        
        if isFetching {
            return
        }
        
        if total <= places.count {
            return
        }
        
        placeNearby(withOffset: places.count, completion: completion)
    }
    
    fileprivate func placeNearby(withOffset offset: Int, completion: PlaceHandler?) {
        var params: [String: Any] = [YelpAPI.Field.offset: offset,
                                     YelpAPI.Field.category: searchRequest.type,
                                     YelpAPI.Field.coordinate: searchRequest.center.description,
                                     YelpAPI.Field.radius: searchRequest.radius]
        
        if let keyword = searchRequest.keyword {
            params[YelpAPI.Field.term] = keyword
        }
        
        isFetching = true
        
        let _ = oauthClient.get(YelpAPI.PlaceURL.search, parameters: params, success: { [unowned self] (response) in
            let json = JSON(response.data)
            
            self.isFetching = false
            
            if let error = json["error"]["text"].string {
                print("\nerror: \(error)\n")
                print("description: \(json["error"]["description"].stringValue)\n")
                print("\(response.request?.allHTTPHeaderFields!)")
            }
            
            self.total = json["total"].intValue
            if let rawPlaces = json["businesses"].arrayObject as? [[String: Any]] {
                self.places.append(contentsOf: rawPlaces.flatMap { YelpPlace(JSON: $0) })
            }
            
            completion?(self.places, nil)
            
        }) { (error) in
            
            completion?(nil, error)
        }
    }
}
