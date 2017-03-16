//
//  RestaurantDetailFont.swift
//  Closr
//
//  Created by Tao on 2017-02-28.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit

struct RestaurantDetailFont {
    
    static let resturantName: UIFont = {
        if Device.is_3_5_inches || Device.is_4_inches {
            return UIFont.systemFont(ofSize: 24)
        }
        
        return UIFont.systemFont(ofSize: 31)
    }()
    
    static let cuisineAndPrice: UIFont = {
        if Device.is_3_5_inches || Device.is_4_inches {
            return UIFont.systemFont(ofSize: 13)
        }
        
        return UIFont.systemFont(ofSize: 15)
    }()
    
    static let infoTitle: UIFont = {
        if Device.is_3_5_inches || Device.is_4_inches {
            return UIFont.systemFont(ofSize: 13)
        }
        
        return UIFont.systemFont(ofSize: 14)
    }()
    
    static let eventTitle: UIFont = {
        if Device.is_3_5_inches || Device.is_4_inches {
            return UIFont.systemFont(ofSize: 16)
        }
        
        return UIFont.systemFont(ofSize: 20)
    }()
    
    static let createEvent: UIFont = {
        if Device.is_3_5_inches || Device.is_4_inches {
            return UIFont.systemFont(ofSize: 16)
        }
        
        return UIFont.systemFont(ofSize: 20)
    }()
    
    static let eventText: UIFont = {
        if Device.is_3_5_inches || Device.is_4_inches {
            return UIFont.systemFont(ofSize: 9)
        }
        
        return UIFont.systemFont(ofSize: 11)
    }()
    
    
}
