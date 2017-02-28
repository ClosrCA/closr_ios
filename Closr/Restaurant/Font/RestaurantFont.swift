//
//  RestaurantFont.swift
//  Closr
//
//  Created by Tao on 2017-02-28.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit

struct RestaurantFont {
    
    static let resturantName: UIFont = {
        if Device.is_3_5_inches || Device.is_4_inches {
            return UIFont(name: "AvenirNextCondensed-Bold", size: 19)!
        }
        
        if Device.is_4_7_inches {
            return UIFont(name: "AvenirNextCondensed-Bold", size: 20)!
        }
        
        return UIFont(name: "AvenirNextCondensed-Bold", size: 22)!
    }()
}
