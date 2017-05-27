//
//  RestaurantListSpace.swift
//  Closr
//
//  Created by Yale的Mac on 2017/3/1.
//  Copyright © 2017年 YaleMac. All rights reserved.
//

import UIKit

struct RestaurantListConstant {
    
    struct Restaurant {
        static let imageSize: CGSize                        = CGSize(width: 112, height: 144)
        static let reviewSize: CGSize                       = CGSize(width: 82, height: 14)
        static let imageCornerRadius: CGFloat               = 10
        static let imagePadding: CGFloat                    = 15
        static let restaurantNameTopPadding: CGFloat        = 20
        static let contentHorizontalPadding: CGFloat        = 13
        static let contentVerticalPadding: CGFloat          = 8
    }
    
    struct Category {
        static let lineSpace: CGFloat   = 13
        static let cellSize: CGSize     = CGSize(width: 123, height: 71)
        static let imageSize: CGSize    = CGSize(width: 133, height: 91)
    }
    
}
