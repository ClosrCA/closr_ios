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
import SwiftyJSON

struct YelpAPIConsole {
    
    static let accessTokenUserDefaultsKey = "yelp_access_token_user_defaults_key"
    
    struct Credentials {
        static let appID        = "28TH0TYk_wx9cE3sBOHtoQ"
        static let secret       = "Xx0rLcJFqOYswyQ5F6sEz89jAKC6BLSeSqXw5S7IPgE0JBIVPHSlHsCfs8eGLB0N"
        static let authorizeURL = "https://api.yelp.com/oauth2/token"
    }
    
    struct PlaceURL {
        static let search = "https://api.yelp.com/v3/businesses/search"
        static let detail = "https://api.yelp.com/v3/businesses/"
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
        static let latitude = "latitude"
        static let longitude = "longitude"
        static let radius = "radius"
        static let category = "categories"
        static let sortBy = "sort_by"
        static let priceFilter = "price"
    }
}

enum SearchError: Error {
    case accessDenied
    case tokenExpired
    
    var localizedDescription: String {
        switch self {
        case .accessDenied: return "Access Denied"
        case .tokenExpired: return "Access token expired"
        }
    }
}
class YelpPlaceSearch {
    
    var searchRequest: PlaceSearchRequest
    
    var places = [YelpPlace]()
    
    fileprivate var isFetching = false
    fileprivate var lastTimeSearchURL: String?
    fileprivate var total: Int = 0
    
    fileprivate var accessToken: String? {
        get {
            return UserDefaults.standard.string(forKey: YelpAPIConsole.accessTokenUserDefaultsKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: YelpAPIConsole.accessTokenUserDefaultsKey)
        }
    }
    
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
        var params: [String: Any] = [YelpAPIConsole.Field.offset: offset,
                                     YelpAPIConsole.Field.category: searchRequest.type,
                                     YelpAPIConsole.Field.latitude: searchRequest.center.latitude,
                                     YelpAPIConsole.Field.longitude: searchRequest.center.longitude,
                                     YelpAPIConsole.Field.radius: searchRequest.radius]
        
        if let keyword = searchRequest.keyword {
            params[YelpAPIConsole.Field.term] = keyword
        }
        
        isFetching = true
        
        if let token = accessToken {
            
            authorizedRequest(token: token, url: YelpAPIConsole.PlaceURL.search, parameters: params, completion: completion)
            
        } else {
            renewAccessToekn(success: { [unowned self] (token) in
                
                self.store(token: token)
                
                self.authorizedRequest(token: token, url: YelpAPIConsole.PlaceURL.search, parameters: params, completion: completion)
                
            }, failure: { (error) in
                completion?(nil, error)
            })
        }
    }
    
    fileprivate func authorizedRequest(token: String, url: URLConvertible, parameters: Parameters?, completion: PlaceHandler?) {
        Alamofire.request(url, parameters: parameters, headers: ["Authorization": "Bearer \(token)"]).responseJSON(completionHandler: { [unowned self] (response) in
            
            self.isFetching = false
            
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                
                // TODO: handle expired token
                
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
                
            case .failure(let error):
                
                completion?(nil, error)
            }
        })
    }
    
    fileprivate func renewAccessToekn(success: ((String) -> Void)?, failure: ((Error) -> Void)?) {
        
        let params = ["client_id": YelpAPIConsole.Credentials.appID, "client_secret": YelpAPIConsole.Credentials.secret, "grant_type": "token"]
        
        Alamofire.request(YelpAPIConsole.Credentials.authorizeURL, method: .post, parameters: params).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                
                if let error = json["error"]["text"].string {
                    print("\nerror: \(error)\n")
                    print("description: \(json["error"]["description"].stringValue)\n")
                    print("\(response.request?.allHTTPHeaderFields!)")
                    
                    failure?(SearchError.accessDenied)
                    
                    return
                }
                
                if let token = json["access_token"].string {
                    success?(token)
                }
                
            case .failure(let error):
                
                failure?(error)
            }
        }
    }
    
    fileprivate func store(token: String) {
        UserDefaults.standard .setValue(token, forKey: YelpAPIConsole.accessTokenUserDefaultsKey)
    }
    
}
