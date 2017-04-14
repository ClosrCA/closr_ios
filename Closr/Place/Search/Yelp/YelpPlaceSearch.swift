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
        static let detail = "https://api.yelp.com/v3/businesses/%@"
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
    
    func placeNearby(completion: PlacesHandler?) {
        
        if isFetching {
            return
        }
        
        places.removeAll()
        
        placeNearby(withOffset: 0, completion: completion)
    }
    
    func nextPage(completion: PlacesHandler?) {
        
        if isFetching {
            return
        }
        
        if total <= places.count {
            return
        }
        
        placeNearby(withOffset: places.count, completion: completion)
    }
    
    func fetch(placeID: String, completion: PlaceDetailHandler?) {
        authorizedFetchRequest(placeID: placeID, completion: completion)
    }
    
    fileprivate func placeNearby(withOffset offset: Int, completion: PlacesHandler?) {
        var params: [String: Any] = [YelpAPIConsole.Field.offset: offset,
                                     YelpAPIConsole.Field.category: searchRequest.type,
                                     YelpAPIConsole.Field.latitude: searchRequest.center.latitude,
                                     YelpAPIConsole.Field.longitude: searchRequest.center.longitude,
                                     YelpAPIConsole.Field.radius: searchRequest.radius]
        
        if let keyword = searchRequest.keyword {
            params[YelpAPIConsole.Field.term] = keyword
        }
        
        isFetching = true
        
        authorizedSearchRequest(parameters: params) { [weak self] (places, error) in
            
            self?.isFetching = false
            
            completion?(places, error)
        }
    }
    
    fileprivate func authorizedSearchRequest(parameters: Parameters?, completion: PlacesHandler?) {
        
        func sendRequest(token: String) {
            
            Alamofire.request(YelpAPIConsole.PlaceURL.search, parameters: parameters, headers: ["Authorization": "Bearer \(token)"]).responseJSON(completionHandler: { [weak self] (response) in
                
                guard let weakSelf = self else {
                    return
                }
                
                switch response.result {
                case .success(let value):
                    
                    let json = JSON(value)
                    
                    // TODO: handle expired token
                    
                    if let error = json["error"]["text"].string {
                        print("\nerror: \(error)\n")
                        print("description: \(json["error"]["description"].stringValue)\n")
                        print("\(String(describing: response.request?.allHTTPHeaderFields!))")
                    }
                    
                    weakSelf.total = json["total"].intValue
                    if let rawPlaces = json["businesses"].arrayObject as? [[String: Any]] {
                        weakSelf.places.append(contentsOf: rawPlaces.flatMap { YelpPlace(JSON: $0) })
                    }
                    
                    completion?(weakSelf.places, nil)
                    
                case .failure(let error):
                    
                    completion?(nil, error)
                }
            })
        }
        
        if let token = accessToken {
            
            sendRequest(token: token)
            
        } else {
            
            renewAccessToekn(success: { (token) in
                
                YelpPlaceSearch.store(token: token)
                
                sendRequest(token: token)
                
            }, failure: { (error) in
                completion?(nil, error)
            })
        }
    }
    
    fileprivate func authorizedFetchRequest(placeID: String, completion: PlaceDetailHandler?) {
        
        func sendRequest(token: String) {

            let urlString = String(format: YelpAPIConsole.PlaceURL.detail, placeID)
            
            Alamofire.request(urlString, headers: ["Authorization": "Bearer \(token)"]).responseObject { (response: DataResponse<YelpPlace>) in
                
                switch response.result {
                case .success(let value):
                    
                    completion?(value, nil)
                    
                case .failure(let error):
                    
                    // TODO: handle expired token
                    
                    completion?(nil, error)
                }
            }
        }
        
        if let token = accessToken {
            
            sendRequest(token: token)
            
        } else {
            
            renewAccessToekn(success: { (token) in
                
                YelpPlaceSearch.store(token: token)
                
                sendRequest(token: token)
                
            }, failure: { (error) in
                completion?(nil, error)
            })
        }
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
                    print("\(String(describing: response.request?.allHTTPHeaderFields!))")
                    
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
    
    class func store(token: String) {
        UserDefaults.standard .setValue(token, forKey: YelpAPIConsole.accessTokenUserDefaultsKey)
    }
    
}
