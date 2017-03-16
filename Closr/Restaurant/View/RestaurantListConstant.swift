//
//  RestaurantListSpace.swift
//  Closr
//
//  Created by Yale的Mac on 2017/3/1.
//  Copyright © 2017年 YaleMac. All rights reserved.
//

import UIKit

struct RestaurantListConstant {
    
    static let restaurantImageViewHeight: CGFloat = {
        
        if Device.is_3_5_inches || Device.is_4_inches {
            return 109
        }
        
        if Device.is_4_7_inches {
            return 128
        }
        
        return 141
    }()
    
    static let restaurantImageViewWidth: CGFloat = {
        
        if Device.is_3_5_inches || Device.is_4_inches {
            return 149
        }
        
        if Device.is_4_7_inches {
            return 175
        }
        
        return 192
    }()
    
    static let restaurantContentTopPadding: CGFloat = {
        
        if Device.is_3_5_inches || Device.is_4_inches {
            return 3.5
        }
        
        if Device.is_4_7_inches {
            return 4.5
        }
        
        return 5
        
    }()
    
    static let promotionRateViewHeight: CGFloat = {
        
        if Device.is_3_5_inches || Device.is_4_inches {
            return 28
        }
        
        if Device.is_4_7_inches {
            return 33
        }
        
        return 37
    }()
    
    static let promotionRateViewWidth: CGFloat = {
        
        if Device.is_3_5_inches || Device.is_4_inches {
            return 124
        }
        
        if Device.is_4_7_inches {
            return 146
        }
        
        return 161
    }()
    
    static let addGroupButtonSize: CGFloat = {
        
        if Device.is_3_5_inches || Device.is_4_inches {
            return 25
        }
        
        if Device.is_4_7_inches {
            return 35
        }
        
        return 45
    }()
    
    static let imageLabelPadding: CGFloat = {
        
        if Device.is_3_5_inches || Device.is_4_inches {
            return 12
        }
        
        if Device.is_4_7_inches {
            return 14.5
        }
        
        return 16
    }()
    
    static let restaurantNameTopPadding: CGFloat = {
        
        if Device.is_3_5_inches || Device.is_4_inches {
            return 1
        }
        
        if Device.is_4_7_inches {
            return 1.5
        }
        
        return 2
    }()
    
    static let distNameTopPadding: CGFloat = {
        
        if Device.is_3_5_inches || Device.is_4_inches {
            return 24.4
        }
        
        if Device.is_4_7_inches {
            return 30
        }
        
        return 32.5
    }()
    
    static let imagePricePadding: CGFloat = {
        
        if Device.is_3_5_inches || Device.is_4_inches {
            return 52
        }
        
        if Device.is_4_7_inches {
            return 61
        }
        
        return 67
    }()
    
    static let restaurantCategoryTopPadding: CGFloat = {
        
        if Device.is_3_5_inches || Device.is_4_inches {
            return 7.5
        }
        
        if Device.is_4_7_inches {
            return 9
        }
        
        return 10
    }()
    
    static let restaurantCategoryButtomPadding: CGFloat = {
        
        if Device.is_3_5_inches || Device.is_4_inches {
            return 11
        }
        
        if Device.is_4_7_inches {
            return 14
        }
        
        return 16
    }()
    
    static let buttonRightPadding: CGFloat = {
        
        if Device.is_3_5_inches || Device.is_4_inches {
            return 13
        }
        
        if Device.is_4_7_inches {
            return 13
        }
        
        return 14
    }()
}
