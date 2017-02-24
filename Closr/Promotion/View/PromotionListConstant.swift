//
//  PromotionListConstant.swift
//  Closr
//
//  Created by Tao on 2017-02-16.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit

struct PromotionListConstant {
    
    static let collectionViewPadding: CGFloat = {
        if Device.is_3_5_inches || Device.is_4_inches {
            return 6
        }
        
        if Device.is_4_7_inches {
            return 9
        }
        
        return 10
    }()
    
    static let minItemSpace: CGFloat = {
        if Device.is_3_5_inches || Device.is_4_inches {
            return 6
        }
        
        if Device.is_4_7_inches {
            return 9
        }
        
        return 10
    }()
    
    struct Cell {
        
        static let height: CGFloat = {
            
            if Device.is_3_5_inches || Device.is_4_inches {
                return 170
            }
            
            if Device.is_4_7_inches {
                return 190
            }
            
            return 210
        }()
        
        static let imageAspectRatio: CGFloat = {
            
            if Device.is_3_5_inches || Device.is_4_inches {
                return 151 / 114
            }
            
            if Device.is_4_7_inches {
                return 174 / 133
            }
            
            return 192 / 146
        }()
        
        static let nameTopPadding: CGFloat = {
           
            return 5
        }()
        
        static let nameBottomPadding: CGFloat = {
            
            return 5
        }()
        
        static let promotionLabelHeight: CGFloat = {
            if Device.is_3_5_inches || Device.is_4_inches {
                return 58
            }
            
            if Device.is_4_7_inches {
                return 68
            }
            
            return 78
        }()
        
        static let promotionLabelWidth: CGFloat = {
            if Device.is_3_5_inches || Device.is_4_inches {
                return 65
            }
            
            if Device.is_4_7_inches {
                return 78
            }
            
            return 88
        }()
    }
}
