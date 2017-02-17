//
//  PromotionFont.swift
//  Closr
//
//  Created by Tao on 2017-02-16.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit

struct PromotionFont {
    
    static let discount: UIFont = {
        if Device.is_3_5_inches || Device.is_4_inches {
            return UIFont.systemFont(ofSize: 26)
        }
        
        if Device.is_4_7_inches {
            return UIFont.systemFont(ofSize: 30)
        }
        
        return UIFont.systemFont(ofSize: 33)
    }()
    
    static let dollarSign: UIFont = {
        if Device.is_3_5_inches || Device.is_4_inches {
            return UIFont.systemFont(ofSize: 20)
        }
        
        if Device.is_4_7_inches {
            return UIFont.systemFont(ofSize: 22)
        }
        
        return UIFont.systemFont(ofSize: 25)
    }()
    
    static let price: UIFont = {
        if Device.is_3_5_inches || Device.is_4_inches {
            return UIFont.systemFont(ofSize: 32)
        }
        
        if Device.is_4_7_inches {
            return UIFont.systemFont(ofSize: 41)
        }
        
        return UIFont.systemFont(ofSize: 45)
    }()
    
    static let quantity: UIFont = {
        if Device.is_3_5_inches || Device.is_4_inches {
            return UIFont.systemFont(ofSize: 20)
        }
        
        if Device.is_4_7_inches {
            return UIFont.systemFont(ofSize: 22)
        }
        
        return UIFont.systemFont(ofSize: 24.5)
    }()
    
    static let item: UIFont = {
        if Device.is_3_5_inches || Device.is_4_inches {
            return UIFont.systemFont(ofSize: 12)
        }
        
        if Device.is_4_7_inches {
            return UIFont.systemFont(ofSize: 14)
        }
        
        return UIFont.systemFont(ofSize: 15)
    }()
    
    static let resturantName: UIFont = {
        if Device.is_3_5_inches || Device.is_4_inches {
            return UIFont.boldSystemFont(ofSize: 19)
        }
        
        if Device.is_4_7_inches {
            return UIFont.boldSystemFont(ofSize: 20)
        }
        
        return UIFont.boldSystemFont(ofSize: 22)
    }()
    
    static let distance: UIFont = {
        if Device.is_3_5_inches || Device.is_4_inches {
            return UIFont.systemFont(ofSize: 12)
        }
        
        if Device.is_4_7_inches {
            return UIFont.systemFont(ofSize: 14)
        }
        
        return UIFont.systemFont(ofSize: 15)
    }()
    
    static let navigationFilter: UIFont = {
        if Device.is_3_5_inches || Device.is_4_inches {
            return UIFont.systemFont(ofSize: 20)
        }
        
        if Device.is_4_7_inches {
            return UIFont.systemFont(ofSize: 24)
        }
        
        return UIFont.systemFont(ofSize: 26)
    }()
}
