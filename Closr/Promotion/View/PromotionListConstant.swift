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
           
            if Device.is_3_5_inches || Device.is_4_inches {
                return 7
            }
            
            if Device.is_4_7_inches {
                return 8
            }
            
            return 9
        }()
        
        static let nameBottomPadding: CGFloat = {
            
            if Device.is_3_5_inches || Device.is_4_inches {
                return 8
            }
            
            return 11
        }()
    }
}
