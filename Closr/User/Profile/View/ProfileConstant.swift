//
//  ProfileConstant.swift
//  Closr
//
//  Created by Tao on 2017-02-12.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit

struct ProfileConstant {
    
    struct AvatarImage {
        
        static let topPadding: CGFloat = {
            
            if Device.is_3_5_inches || Device.is_4_inches {
                return 40
            }
            
            if Device.is_4_7_inches {
                return 70
            }
            
            return 80
        }()
        
        static let size: CGFloat = {
            if Device.is_3_5_inches || Device.is_4_inches {
                return 100
            }
            
            if Device.is_4_7_inches {
                return 120
            }
            
            return 140
        }()
        
        static let bottomPadding: CGFloat = {
            
            if Device.is_3_5_inches || Device.is_4_inches {
                return 35
            }
            
            if Device.is_4_7_inches {
                return 38
            }
            
            return 75
            
        }()
    }
    
    struct NameLabel {
        
        static let bottomPadding: CGFloat = {
            
            if Device.is_3_5_inches || Device.is_4_inches {
                return 20
            }
            
            return 38
            
        }()
    }
    
    struct TextField {
        
        static let height: CGFloat = {
            
            if Device.is_3_5_inches || Device.is_4_inches {
                return 40
            }
            
            return 50
        }()
        
        static let horizontalPadding: CGFloat = {
            
            if Device.is_3_5_inches || Device.is_4_inches || Device.is_4_7_inches {
                return 10
            }
            
            return 20
        }()
        
        static let verticalPadding: CGFloat = {
            
            if Device.is_3_5_inches || Device.is_4_inches {
                return 20
            }
            
            return 30
        }()
        
        static let iconSize: CGFloat = {
            if Device.is_3_5_inches || Device.is_4_inches || Device.is_4_7_inches {
                return 30
            }
            
            return 40
        }()
    }
    
    struct ConfirmButton {
        static let height: CGFloat = {
            
            if Device.is_3_5_inches || Device.is_4_inches {
                return 50
            }
            
            return 70
        }()
    }
}
