//
//  Place.swift
//  Closr
//
//  Created by Tao on 2017-01-25.
//  Copyright © 2017 closr. All rights reserved.
//

import Foundation
import ObjectMapper


class Place: Mappable {
    var name: String?
    var address: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
    }
}
