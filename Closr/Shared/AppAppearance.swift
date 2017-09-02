//
//  AppAppearance.swift
//  Closr
//
//  Created by Tao on 2017-02-16.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit

struct AppColor {
    static let brand        = UIColor(red:232 / 255, green:111 / 255, blue:1 / 255,  alpha:1)
    static let secondary    = UIColor(red: 243 / 255, green: 186 / 255, blue: 177 / 255, alpha: 1.0)
    
    static let border       = UIColor(red: 149 / 255, green: 152 / 255, blue: 154 / 255, alpha: 0.2)
    
    static let text_dark         = UIColor(red: 89 / 255, green: 89 / 255, blue: 87 / 255, alpha: 1.0)
    static let text_gray         = UIColor(red: 149 / 255, green: 149 / 255, blue: 149 / 255, alpha: 1.0)
    static let text_light_gray   = UIColor(red: 220 / 255, green: 221 / 255, blue: 221 / 255, alpha: 1.0)
    
    static let background_gray   = UIColor(red: 159 / 255, green: 159 / 255, blue: 160 / 255, alpha: 0.56)
    static let background_brand  = UIColor(red: 86 / 255, green: 34 / 255, blue: 26 / 255, alpha: 0.1)
}

struct AppFont {
    static let largeTitle: UIFont   = UIFont.systemFont(ofSize: 28, weight: UIFontWeightSemibold)
    static let thinTitle: UIFont    = UIFont(name: "AvenirNextCondensed-Bold", size: 20)!
    static let title: UIFont        = UIFont.systemFont(ofSize: 18, weight: UIFontWeightSemibold)
    static let text: UIFont         = UIFont.systemFont(ofSize: 15, weight: UIFontWeightRegular)
    static let smallText: UIFont    = UIFont.systemFont(ofSize: 10, weight: UIFontWeightLight)
}

struct AppSizeMetric {
    static let buttonHeight: CGFloat    = 44
    static let defaultPadding: CGFloat  = 8
    static let breathPadding: CGFloat   = 20
    static let avatarSize: CGSize       = CGSize(width: 55, height: 55)
    static let chatAvatarSize: CGSize   = CGSize(width: 20, height: 20)
    static let iconSize: CGSize         = CGSize(width: 12, height: 12)
}
