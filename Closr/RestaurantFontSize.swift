//
//  RestaurantFontSize.swift
//  TableViewTest
//
//  Created by Yale的Mac on 2017/3/1.
//  Copyright © 2017年 YaleMac. All rights reserved.
//

import UIKit

class RestaurantFontSize: NSObject {
    
    
    /*
     
     
     static let discount: UIFont = {
     if Device.is_3_5_inches || Device.is_4_inches {
     return UIFont.systemFont(ofSize: 26)
     }
     
     if Device.is_4_7_inches {
     return UIFont.systemFont(ofSize: 30)
     }
     
     return UIFont.systemFont(ofSize: 33)
     }()
     
     
     
     */
    
    
    //RestaurantName
    
    
    
    static let restaurantNameSize: UIFont = {
        if Device.is_3_5_inches || Device.is_4_inches {
            return UIFont.systemFont(ofSize: 15)
        }
        
        if Device.is_4_7_inches {
            return UIFont.systemFont(ofSize: 18)
        }
        
        return UIFont.systemFont(ofSize: 19.5)
    }()
    
    
    //RestaurantAddress
    
    static let restaurantAddressSize: UIFont = {
        if Device.is_3_5_inches || Device.is_4_inches {
            return UIFont.systemFont(ofSize: 11)
        }
        
        if Device.is_4_7_inches {
            return UIFont.systemFont(ofSize: 12)
        }
        
        return UIFont.systemFont(ofSize: 13.5)
    }()
    
    
    //RestaurantDist
    
    static let restaurantDistSize: UIFont = {
        if Device.is_3_5_inches || Device.is_4_inches {
            return UIFont.systemFont(ofSize: 11)
        }
        
        if Device.is_4_7_inches {
            return UIFont.systemFont(ofSize: 12)
        }
        
        return UIFont.systemFont(ofSize: 13.5)
    }()
    
    
    //RestaurantPrice
    
    static let restaurantPriceSize: UIFont = {
        if Device.is_3_5_inches || Device.is_4_inches {
            return UIFont.systemFont(ofSize: 11)
        }
        
        if Device.is_4_7_inches {
            return UIFont.systemFont(ofSize: 12)
        }
        
        return UIFont.systemFont(ofSize: 13.5)
    }()
    
    
    //restaurantCategory
    
    static let restaurantCategorySize: UIFont = {
        if Device.is_3_5_inches || Device.is_4_inches {
            return UIFont.systemFont(ofSize: 8.5)
        }
        
        if Device.is_4_7_inches {
            return UIFont.systemFont(ofSize: 10)
        }
        
        return UIFont.systemFont(ofSize: 11)
    }()
    
    
    
    
    //promotionRate
    
    static let promotionRateSize: UIFont = {
        if Device.is_3_5_inches || Device.is_4_inches {
            return UIFont.systemFont(ofSize: 8.5)
        }
        
        if Device.is_4_7_inches {
            return UIFont.systemFont(ofSize: 9.5)
        }
        
        return UIFont.systemFont(ofSize: 11)
    }()
    
    //addGroupButton
    
}
