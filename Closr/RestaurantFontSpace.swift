//
//  RestaurantFontSpace.swift
//  TableViewTest
//
//  Created by Yale的Mac on 2017/3/1.
//  Copyright © 2017年 YaleMac. All rights reserved.
//

import UIKit


struct spaceStruct {
    
    
    var originX=0.0
    var originY=0.0
    var sizeWidth=0.0
    var sizeHeight=0.0
}


class RestaurantFontSpace: NSObject {
    
    
    //RestaurantName
    
    static let restaurantNameSpace: spaceStruct = {
        if Device.is_3_5_inches || Device.is_4_inches {
            return spaceStruct(originX:151,originY:1,sizeWidth:200,sizeHeight:15)
        }
        
        if Device.is_4_7_inches {
            return spaceStruct(originX:189.5,originY:1.5,sizeWidth:220,sizeHeight:18)
        }
        
        return spaceStruct(originX:208,originY:2,sizeWidth:250,sizeHeight:19.5)
    }()
    
    //RestaurantAddress
    
    
    static let restaurantAddressSpace: spaceStruct = {
        if Device.is_3_5_inches || Device.is_4_inches {
            return spaceStruct(originX:151,originY:28,sizeWidth:200,sizeHeight:11)
        }
        
        if Device.is_4_7_inches {
            return spaceStruct(originX:189.5,originY:34,sizeWidth:220,sizeHeight:12)
        }
        
        return spaceStruct(originX:208,originY:36.5,sizeWidth:250,sizeHeight:13.5)
    }()
    
    
    //RestaurantDist
    
    
    static let restaurantDistSpace: spaceStruct = {
        if Device.is_3_5_inches || Device.is_4_inches {
            return spaceStruct(originX:151,originY:82,sizeWidth:50,sizeHeight:11)
        }
        
        if Device.is_4_7_inches {
            return spaceStruct(originX:189.5,originY:85,sizeWidth:220,sizeHeight:12)
        }
        
        return spaceStruct(originX:208,originY:106,sizeWidth:250,sizeHeight:13.5)
    }()
    
    
    //RestaurantPrice
    
    static let restaurantPriceSpace: spaceStruct = {
        if Device.is_3_5_inches || Device.is_4_inches {
            return spaceStruct(originX:201,originY:82,sizeWidth:200,sizeHeight:11)
        }
        
        if Device.is_4_7_inches {
            return spaceStruct(originX:236,originY:85,sizeWidth:220,sizeHeight:12)
        }
        
        return spaceStruct(originX:259,originY:106,sizeWidth:250,sizeHeight:13.5)
    }()
    
    
    //restaurantCategory
    
    static let restaurantCategorySpace: spaceStruct = {
        if Device.is_3_5_inches || Device.is_4_inches {
            return spaceStruct(originX:151,originY:100.5,sizeWidth:200,sizeHeight:8.5)
        }
        
        if Device.is_4_7_inches {
            return spaceStruct(originX:189.5,originY:106,sizeWidth:220,sizeHeight:10)
        }
        
        return spaceStruct(originX:208,originY:129.5,sizeWidth:250,sizeHeight:11)
    }()
    
    
    
    //restaurantImageView
    
    static let restaurantImageViewSpace: spaceStruct = {
        if Device.is_3_5_inches || Device.is_4_inches {
            return spaceStruct(originX:0,originY:0,sizeWidth:149,sizeHeight:109)
        }
        
        if Device.is_4_7_inches {
            return spaceStruct(originX:0,originY:0,sizeWidth:175,sizeHeight:128)
        }
        
        return spaceStruct(originX:0,originY:0,sizeWidth:192,sizeHeight:141)
    }()
    
    
    //cellDistance
    
    static let cellDistanceSpace: spaceStruct = {
        if Device.is_3_5_inches || Device.is_4_inches {
            return spaceStruct(originX:0,originY:109,sizeWidth:320,sizeHeight:3.5)
        }
        
        if Device.is_4_7_inches {
            return spaceStruct(originX:0,originY:128,sizeWidth:375,sizeHeight:4.5)
        }
        
        return spaceStruct(originX:0,originY:141,sizeWidth:414,sizeHeight:5)
    }()
    
    
    //promotionRateView
    
    static let promotionRateViewSpace: spaceStruct = {
        if Device.is_3_5_inches || Device.is_4_inches {
            return spaceStruct(originX:25,originY:70,sizeWidth:124,sizeHeight:28)
        }
        
        if Device.is_4_7_inches {
            return spaceStruct(originX:29,originY:81,sizeWidth:146,sizeHeight:33)
        }
        
        return spaceStruct(originX:31,originY:88,sizeWidth:161,sizeHeight:37)
    }()
    
    
    
    
    //addGroupButton
    
    static let addGroupButtonSpace: spaceStruct = {
        if Device.is_3_5_inches || Device.is_4_inches {
            return spaceStruct(originX:282,originY:82,sizeWidth:25,sizeHeight:25)
        }
        
        if Device.is_4_7_inches {
            return spaceStruct(originX:330,originY:83,sizeWidth:35,sizeHeight:35)
        }
        
        return spaceStruct(originX:350,originY:95,sizeWidth:45,sizeHeight:45)
    }()
    
    
    static let imageLabelSpace:CGFloat={
        
        if Device.is_3_5_inches || Device.is_4_inches {
            return 12
        }
        
        if Device.is_4_7_inches {
            return 14.5
        }
        
        return 16
        
        
    }()
    
    static let restaurantTopSpace:CGFloat={
        
        if Device.is_3_5_inches || Device.is_4_inches {
            return 1
        }
        
        if Device.is_4_7_inches {
            return 1.5
        }
        
        return 2
        
        
    }()
    
    static let distNameSpace:CGFloat={
        
        if Device.is_3_5_inches || Device.is_4_inches {
            return 32
        }
        
        if Device.is_4_7_inches {
            return 37
        }
        
        return 40
        
        
    }()
    
    static let imagePriceSpace:CGFloat={
        
        if Device.is_3_5_inches || Device.is_4_inches {
            return 52
        }
        
        if Device.is_4_7_inches {
            return 61
        }
        
        return 67
        
        
    }()
    
    static let categoryTopSpace:CGFloat={
        
        if Device.is_3_5_inches || Device.is_4_inches {
            return 7.5
        }
        
        if Device.is_4_7_inches {
            return 9
        }
        
        return 10
        
        
    }()
    
    static let categoryButtomSpace:CGFloat={
        
        if Device.is_3_5_inches || Device.is_4_inches {
            return 11
        }
        
        if Device.is_4_7_inches {
            return 14
        }
        
        return 16
        
        
    }()
    
    static let buttonRightSpace:CGFloat={
        
        if Device.is_3_5_inches || Device.is_4_inches {
            return 13
        }
        
        if Device.is_4_7_inches {
            return 13
        }
        
        return 14
        
        
    }()
    
    
}
