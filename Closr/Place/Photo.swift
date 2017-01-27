//
//  Photo.swift
//  Closr
//
//  Created by Tao on 2017-01-27.
//  Copyright © 2017 closr. All rights reserved.
//

import Alamofire
import AlamofireImage
import ObjectMapper

class Photo: Mappable {
    var height: Double?
    var width: Double?
    var reference: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        height      <- map["height"]
        width       <- map["width"]
        reference   <- map["photo_reference"]
    }
}

typealias ImageHandler = ((UIImage?, Error?) -> Void)

extension Photo {
    
    func loadImage(maxWidth: CGFloat, completion: ImageHandler?) {
        
        guard let reference = reference else {
            return
        }
        
        let params = GoogleAPI.authenticate(params: ["photoreference": reference, "maxwidth": maxWidth])
        
        Alamofire.request(GoogleAPI.PlaceURL.photo, parameters: params).responseImage { (response) in
            
            switch response.result {
            case .success(let value):
                completion?(value, nil)
            case .failure(let error):
                completion?(nil, error)
            }
        }
    }
}
