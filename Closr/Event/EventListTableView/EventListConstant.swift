//
//  EventListConstant.swift
//  Closr
//
//  Created by Yale的Mac on 2017/3/31.
//  Copyright © 2017年 closr. All rights reserved.
//

import UIKit

struct EventListConstant  {
    
    static let nearbyImageViewHeight: CGFloat = {
        
        if Device.is_3_5_inches || Device.is_4_inches {
            return 63
        }
        
        if Device.is_4_7_inches {
            return 82
        }
        
        return 82
    }()
    
    static let nearbyImageViewWidth: CGFloat = {
        
        if Device.is_3_5_inches || Device.is_4_inches {
            return 63
        }
        
        if Device.is_4_7_inches {
            return 82
        }
        
        return 82
    }()
    
    static let nearbyImageViewLeadingPadding: CGFloat = {
        
        if Device.is_3_5_inches || Device.is_4_inches {
            return 25
        }
        
        if Device.is_4_7_inches {
            return 31
        }
        
        return 34
    }()
    
    
    static let nearbyImageViewTopPadding: CGFloat = {
        
        if Device.is_3_5_inches || Device.is_4_inches {
            return 13
        }
        
        if Device.is_4_7_inches {
            return 15.5
        }
        
        return 17
    }()
    
    
    static let nearbyReataurantNameTopPadding: CGFloat = {
        
        if Device.is_3_5_inches || Device.is_4_inches {
            return 10
        }
        
        if Device.is_4_7_inches {
            return 12.5
        }
        
        return 14
    }()
    
    static let nearbyLabelImageViewPadding: CGFloat = {
        
        if Device.is_3_5_inches || Device.is_4_inches {
            return 21
        }
        
        if Device.is_4_7_inches {
            return 24
        }
        
        return 26
    }()
    
    static let nearbyRestaurantAddressTopPadding: CGFloat = {
        
        if Device.is_3_5_inches || Device.is_4_inches {
            return 3.5
        }
        
        if Device.is_4_7_inches {
            return 5
        }
        
        return 6
        
    }()
    
    static let nearbyDateTopPadding: CGFloat = {
        
        if Device.is_3_5_inches || Device.is_4_inches {
            return 4.5
        }
        
        if Device.is_4_7_inches {
            return 7
        }
        
        return 9
        
    }()
    
    static let nearbyDistanceTopPadding: CGFloat = {
        
        if Device.is_3_5_inches || Device.is_4_inches {
            return 1
        }
        
        if Device.is_4_7_inches {
            return 2
        }
        
        return 3
        
    }()
    
    static let nearbyDistanceBottomPadding: CGFloat = {
        
        if Device.is_3_5_inches || Device.is_4_inches {
            return 13
        }
        
        if Device.is_4_7_inches {
            return 16
        }
        
        return 18
        
    }()
    
    static let sectionHeaderLeadingPadding: CGFloat = {
        
        if Device.is_3_5_inches || Device.is_4_inches {
            return 17
        }
        
        if Device.is_4_7_inches {
            return 20
        }
        
        return 22
    }()
    
    static let sectionHeaderHeight: CGFloat = {
        
        if Device.is_3_5_inches || Device.is_4_inches {
            return 24
        }
        
        if Device.is_4_7_inches {
            return 30
        }
        
        return 34
    }()
    
    static let sectionHeaderTopBottomPadding: CGFloat = {
        
        if Device.is_3_5_inches || Device.is_4_inches {
            return 5
        }
        
        if Device.is_4_7_inches {
            return 7
        }
        
        return 8
    }()
    
    
}
