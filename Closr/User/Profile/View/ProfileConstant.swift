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
                return 56
            }
            
            if Device.is_4_7_inches {
                return 78
            }
            
            return 81
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
                return 19
            }
            
            if Device.is_4_7_inches {
                return 23
            }
            
            return 25
            
        }()
    }
    
    struct NameLabel {
        
        static let bottomPadding: CGFloat = {
            
            if Device.is_3_5_inches || Device.is_4_inches {
                return 44
            }
            
            if Device.is_4_7_inches {
                return 51.5
            }
            
            return 57
            
        }()
    }
    
    struct TextField {
        
        static let height: CGFloat = {
            
            if Device.is_3_5_inches || Device.is_4_inches {
                return 34
            }
            
            if Device.is_4_7_inches {
                return 39.5
            }
            
            return 44
        }()
        
        static let horizontalPadding: CGFloat = {
            
            if Device.is_3_5_inches || Device.is_4_inches {
                return 25
            }
            
            if Device.is_4_7_inches {
                return 29
            }
            
            return 31
        }()
        
        static let verticalPadding: CGFloat = {
            
            if Device.is_3_5_inches || Device.is_4_inches {
                return 35
            }
            
            if Device.is_4_7_inches {
                return 41.5
            }
            
            return 46
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
                return 46.5
            }
            
            if Device.is_4_7_inches {
                return 54
            }
            
            return 61
        }()
    }
}
