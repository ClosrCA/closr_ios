//
//  YelpAPI.swift
//  Closr
//
//  Created by ZHITAO TIAN on 2018-05-06.
//  Copyright © 2018 closr. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import SwiftyJSON

struct YelpAPI {
    
    struct Console {
        
        static let clientID = "nG3Rf_t32eiAg3EHB8Jszg"
        static let apiKey   = "7F_Rjh7_hYT6hCjeP9eNr_NDiW5oHAaTV2tvprYRU8izCdzzozmlFLfWAIojDyVBsEGORao2wCRo-r1fq2gWzqRqQCXwj8cFH9z9J9AdeO96BhT6_c0UskZ-IcNaWXYx"
        
        struct PlaceURL {
            static let search = "https://api.yelp.com/v3/businesses/search"
            static let detail = "https://api.yelp.com/v3/businesses/%@"
        }
    }
    
    static func getPlaceList(parameters: Parameters?, onSuccess: (([YelpPlace], Int) -> Void)?, onFailure: ((String) -> Void)?) {
        
        Alamofire.request(Console.PlaceURL.search, parameters: parameters, headers: ["Authorization": "Bearer \(Console.apiKey)"]).responseJSON(completionHandler: { (response) in
            
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                
                if let error = json["error"]["description"].string {
                    print("\n error: \(error)\n")
                    onFailure?(error)
                    return
                }
                
                let total = json["total"].intValue
                var places = [YelpPlace]()
                if let rawPlaces = json["businesses"].arrayObject as? [[String: Any]] {
                    places.append(contentsOf: rawPlaces.flatMap { YelpPlace(JSON: $0) })
                }
                
                onSuccess?(places, total)
                
            case .failure(let error):
                
                onFailure?(error.localizedDescription)
            }
        })
    }
    
    static func getPlaceDetail(placeID: String, onSuccess: ((YelpPlace) -> Void)?, onFailure: ((String) -> Void)?) {
        
        let urlString = String(format: Console.PlaceURL.detail, placeID)
        
        Alamofire.request(urlString, headers: ["Authorization": "Bearer \(Console.apiKey)"]).responseObject { (response: DataResponse<YelpPlace>) in
            
            switch response.result {
            case .success(let value):
                
                onSuccess?(value)
                
            case .failure(let error):
                
                onFailure?(error.localizedDescription)
            }
        }
    }
}
