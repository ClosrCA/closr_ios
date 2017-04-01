//
//  EventListFont.swift
//  Closr
//
//  Created by Yale的Mac on 2017/3/31.
//  Copyright © 2017年 closr. All rights reserved.
//

import UIKit

class EventListFont: NSObject {
    
    
    static let sectionHeader: UIFont = {
        if Device.is_3_5_inches || Device.is_4_inches {
            return UIFont.systemFont(ofSize: 12)
        }
        
        if Device.is_4_7_inches {
            return UIFont.systemFont(ofSize: 14)
        }
        
        return UIFont.systemFont(ofSize: 15.5)
    }()
    
    
    static let nearbyRestaurantName: UIFont = {
        if Device.is_3_5_inches || Device.is_4_inches {
            return UIFont.systemFont(ofSize: 14)
        }
        
        if Device.is_4_7_inches {
            return UIFont.systemFont(ofSize: 16.5)
        }
        
        return UIFont.systemFont(ofSize: 18)
    }()
    
    
    
    static let nearbyRestuarantAddress: UIFont = {
        if Device.is_3_5_inches || Device.is_4_inches {
            return UIFont.systemFont(ofSize: 10)
        }
        
        if Device.is_4_7_inches {
            return UIFont.systemFont(ofSize: 12)
        }
        
        return UIFont.systemFont(ofSize: 13)
    }()
    
    
    static let nearbyDate: UIFont = {
        if Device.is_3_5_inches || Device.is_4_inches {
            return UIFont.systemFont(ofSize: 10)
        }
        
        if Device.is_4_7_inches {
            return UIFont.systemFont(ofSize: 12)
        }
        
        return UIFont.systemFont(ofSize: 13)
    }()
    
    
    static let nearbyRestaruantDistance: UIFont = {
        if Device.is_3_5_inches || Device.is_4_inches {
            return UIFont.systemFont(ofSize: 10)
        }
        
        if Device.is_4_7_inches {
            return UIFont.systemFont(ofSize: 12)
        }
        
        return UIFont.systemFont(ofSize: 13)
    }()
    
    
}
