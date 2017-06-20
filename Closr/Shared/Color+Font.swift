//
//  Theme.swift
//  Closr
//
//  Created by Tao on 2017-02-16.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit

struct AppColor {
    static let brand        = UIColor(red:232 / 255.0, green:111 / 255.0, blue:1 / 255.0,  alpha:1)
    static let secondary    = UIColor(red: 243 / 255, green: 186 / 255, blue: 177 / 255, alpha: 1.0)
    
    static let title            = UIColor(red: 89 / 255, green: 89 / 255, blue: 87 / 255, alpha: 1.0)
    static let greyText         = UIColor(red: 149 / 255, green: 149 / 255, blue: 149 / 255, alpha: 1.0)
    static let lightGreyText    = UIColor(red: 220 / 255, green: 221 / 255, blue: 221 / 255, alpha: 1.0)
    static let hightedText      = UIColor.white
    
    static let lightButtonTitle = UIColor.white
    static let darkButtonTitle  = UIColor(red: 89 / 255, green: 89 / 255, blue: 87 / 255, alpha: 1.0)
    
    static let greyBackground = UIColor(red: 159 / 255, green: 159 / 255, blue: 160 / 255, alpha: 0.56)
    static let brandBackground = UIColor(red: 86 / 255, green: 34 / 255, blue: 26 / 255, alpha: 0.1)
}

struct AppFont {
    
    static let largeTitle: UIFont = {
        
        if Device.is_3_5_inches || Device.is_4_inches {
            return UIFont.systemFont(ofSize: 24, weight: UIFontWeightSemibold)
        }
        
        return UIFont.systemFont(ofSize: 31, weight: UIFontWeightSemibold)
    }()
    
    static let thinTitle: UIFont = {
        if Device.is_3_5_inches || Device.is_4_inches {
            return UIFont(name: "AvenirNextCondensed-Bold", size: 19)!
        }
        
        if Device.is_4_7_inches {
            return UIFont(name: "AvenirNextCondensed-Bold", size: 20)!
        }
        
        return UIFont(name: "AvenirNextCondensed-Bold", size: 22)!
    }()
    
    static let title: UIFont = {
        if Device.is_3_5_inches || Device.is_4_inches {
            return UIFont.systemFont(ofSize: 19, weight: UIFontWeightSemibold)
        }
        
        if Device.is_4_7_inches {
            return UIFont.systemFont(ofSize: 20, weight: UIFontWeightSemibold)
        }
        
        return UIFont.systemFont(ofSize: 22, weight: UIFontWeightSemibold)
    }()
    
    static let text: UIFont = {
        if Device.is_3_5_inches || Device.is_4_inches {
            return UIFont.systemFont(ofSize: 15, weight: UIFontWeightRegular)
        }
        
        if Device.is_4_7_inches {
            return UIFont.systemFont(ofSize: 18, weight: UIFontWeightRegular)
        }
        
        return UIFont.systemFont(ofSize: 20, weight: UIFontWeightRegular)
    }()
    
    static let smallText: UIFont = {
        if Device.is_3_5_inches || Device.is_4_inches {
            return UIFont.systemFont(ofSize: 11, weight: UIFontWeightLight)
        }
        
        if Device.is_4_7_inches {
            return UIFont.systemFont(ofSize: 12, weight: UIFontWeightLight)
        }
        
        return UIFont.systemFont(ofSize: 13, weight: UIFontWeightLight)
    }()
    
    static let extraSmallText: UIFont = UIFont.systemFont(ofSize: 8, weight: UIFontWeightLight)
}

extension UIViewController {
    
    func transparentNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage     = UIImage()
    }
    
    func defaultNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UINavigationBar.appearance().backgroundImage(for: .default), for: .default)
        navigationController?.navigationBar.shadowImage     = UINavigationBar.appearance().shadowImage
    }
}
