//
//  Device.swift
//  Closr
//
//  Created by Tao on 2017-02-12.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit

struct Device {
    
    static let screenWidth  = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
    
    fileprivate struct Height {
        static let inches_3_5: CGFloat  = 480
        static let inches_4: CGFloat    = 568
        static let inches_4_7: CGFloat  = 667
        static let inches_5_5: CGFloat  = 736
    }

    static let currentDeviceHeight = UIScreen.main.bounds.height
    
    static var is_3_5_inches: Bool {
        return currentDeviceHeight == Height.inches_3_5
    }
    
    static var is_4_inches: Bool {
        return currentDeviceHeight == Height.inches_4
    }
    
    static var is_4_7_inches: Bool {
        return currentDeviceHeight == Height.inches_4_7
    }
    
    static var is_5_5_inches: Bool {
        return currentDeviceHeight == Height.inches_5_5
    }
}
