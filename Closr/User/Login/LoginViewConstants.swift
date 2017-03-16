//
//  LoginViewConstants.swift
//  Closr
//
//  Created by Zhitao on 2017-03-16.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit

struct LoginViewConstants {
    static let facebookButtonBottomPadding: CGFloat = {
        if Device.is_3_5_inches || Device.is_4_inches {
            return 185
        }
        
        if Device.is_4_7_inches {
            return 205
        }
        
        return 240
    }()
    
    static let termsLabelPadding: CGFloat = 30
}
