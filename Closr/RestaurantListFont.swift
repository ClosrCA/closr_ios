//
//  RestaurantListFont.swift
//  Closr
//
//  Created by Yale的Mac on 2017/3/1.
//  Copyright © 2017年 YaleMac. All rights reserved.
//

import UIKit

struct RestaurantListFont {

    static let restaurantName: UIFont = {
        if Device.is_3_5_inches || Device.is_4_inches {
            return UIFont.systemFont(ofSize: 15)
        }
        
        if Device.is_4_7_inches {
            return UIFont.systemFont(ofSize: 18)
        }
        
        return UIFont.systemFont(ofSize: 19.5)
    }()
    
    static let address: UIFont = {
        if Device.is_3_5_inches || Device.is_4_inches {
            return UIFont.systemFont(ofSize: 11)
        }
        
        if Device.is_4_7_inches {
            return UIFont.systemFont(ofSize: 12)
        }
        
        return UIFont.systemFont(ofSize: 13.5)
    }()
    
    static let distance: UIFont = {
        if Device.is_3_5_inches || Device.is_4_inches {
            return UIFont.systemFont(ofSize: 11)
        }
        
        if Device.is_4_7_inches {
            return UIFont.systemFont(ofSize: 12)
        }
        
        return UIFont.systemFont(ofSize: 13.5)
    }()
    
    static let price: UIFont = {
        if Device.is_3_5_inches || Device.is_4_inches {
            return UIFont.systemFont(ofSize: 11)
        }
        
        if Device.is_4_7_inches {
            return UIFont.systemFont(ofSize: 12)
        }
        
        return UIFont.systemFont(ofSize: 13.5)
    }()
    
    static let category: UIFont = {
        if Device.is_3_5_inches || Device.is_4_inches {
            return UIFont.systemFont(ofSize: 8.5)
        }
        
        if Device.is_4_7_inches {
            return UIFont.systemFont(ofSize: 10)
        }
        
        return UIFont.systemFont(ofSize: 11)
    }()
    
    static let promotionRate: UIFont = {
        if Device.is_3_5_inches || Device.is_4_inches {
            return UIFont.systemFont(ofSize: 8.5)
        }
        
        if Device.is_4_7_inches {
            return UIFont.systemFont(ofSize: 9.5)
        }
        
        return UIFont.systemFont(ofSize: 11)
    }()
}
