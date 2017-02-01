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

class GooglePhoto: Photo, Mappable {
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

