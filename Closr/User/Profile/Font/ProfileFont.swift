//
//  ProfileFont.swift
//  Closr
//
//  Created by Tao on 2017-02-12.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit

struct ProfileFont {
    
    static let nameTitle: UIFont = {
        if Device.is_3_5_inches || Device.is_4_inches || Device.is_4_7_inches {
            return UIFont.systemFont(ofSize: 40)
        }
        
        return UIFont.systemFont(ofSize: 80)
    }()
    
    static let text: UIFont = {
        if Device.is_3_5_inches || Device.is_4_inches || Device.is_4_7_inches {
            return UIFont.systemFont(ofSize: 24)
        }
        
        return UIFont.systemFont(ofSize: 46)
    }()
    
    static let buttonTitle: UIFont = {
        if Device.is_3_5_inches || Device.is_4_inches || Device.is_4_7_inches {
            return UIFont.systemFont(ofSize: 36)
        }
        
        return UIFont.systemFont(ofSize: 70)
    }()
}
