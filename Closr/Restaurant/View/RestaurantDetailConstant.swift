//
//  RestaurantDetailConstant.swift
//  Closr
//
//  Created by Tao on 2017-03-08.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit

struct RestaurantDetailConstant {
    
    static let heroImageHeight: CGFloat = {
        if Device.is_3_5_inches || Device.is_4_inches {
            return 233
        }
        
        return 299
    }()
    
    static let restaurantNameTopPadding: CGFloat = {
        if Device.is_3_5_inches || Device.is_4_inches {
            return 15
        }
        
        return 18
    }()
    
    static let reviewTopPadding: CGFloat = {
        if Device.is_3_5_inches || Device.is_4_inches {
            return 6
        }
        
        return 9
    }()
    
    static let cuisineTopPadding: CGFloat = {
        if Device.is_3_5_inches || Device.is_4_inches {
            return 6
        }
        
        return 9
    }()
    
    static let infoSectionVerticalPadding: CGFloat = {
        if Device.is_3_5_inches || Device.is_4_inches {
            return 18
        }
        
        return 22
    }()
    
    static let infoSectionLeadingPadding: CGFloat = {
        if Device.is_3_5_inches || Device.is_4_inches {
            return 35
        }
        
        if Device.is_4_7_inches {
            return 40
        }
        
        return 50
    }()
    
    static let infoInternalPadding: CGFloat = {
        if Device.is_3_5_inches || Device.is_4_inches {
            return 6
        }
        
        if Device.is_4_7_inches {
            return 8
        }
        
        return 10
    }()
    
    struct EventList {
        static let eventDividerHeight: CGFloat = 3
        
        static let eventListHorizontalPadding: CGFloat = 20
        
        static let eventTitleVerticalPadding: CGFloat = {
            if Device.is_3_5_inches || Device.is_4_inches {
                return 14
            }
            
            return 18
        }()
        
        static let avatarSize: CGFloat = {
            if Device.is_3_5_inches || Device.is_4_inches {
                return 30
            }
            
            if Device.is_4_7_inches {
                return 38
            }
            
            return 42
        }()
        
        static let avatarVerticalPadding: CGFloat   = 10
        static let avatarLeftPadding: CGFloat       = 10
        static let avatarRightPadding: CGFloat      = 30
        
        static let timeLabelRightPadding: CGFloat   = 20
        static let timeLabelBottomPadding: CGFloat  = 12
        
        static let numberLabelRightPadding: CGFloat = 44
        
        static let joinButtonWidth: CGFloat     = 40
        static let joinButtonHeight: CGFloat    = 12
        
        static let createEventButtonPadding: CGFloat  = 10
        static let createEventButtonHeight: CGFloat   = 44
    }
    
}
