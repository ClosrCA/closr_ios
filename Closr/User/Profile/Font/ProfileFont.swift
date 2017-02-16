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
        if Device.is_3_5_inches || Device.is_4_inches {
            return UIFont.systemFont(ofSize: 21)
        }
        
        if Device.is_4_7_inches {
            return UIFont.systemFont(ofSize: 24.5)
        }
        
        return UIFont.systemFont(ofSize: 27)
    }()
    
    static let text: UIFont = {
        if Device.is_3_5_inches || Device.is_4_inches {
            return UIFont.systemFont(ofSize: 12)
        }
        
        if Device.is_4_7_inches {
            return UIFont.systemFont(ofSize: 14)
        }
        
        return UIFont.systemFont(ofSize: 16)
    }()
    
    static let buttonTitle: UIFont = {
        if Device.is_3_5_inches || Device.is_4_inches {
            return UIFont.systemFont(ofSize: 16)
        }
        
        if Device.is_4_7_inches {
            return UIFont.systemFont(ofSize: 18)
        }
        
        return UIFont.systemFont(ofSize: 20)
    }()
}
