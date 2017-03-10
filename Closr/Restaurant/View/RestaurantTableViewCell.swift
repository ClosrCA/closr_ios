//
//  RestaurantTableViewCell.swift
//  Closr
//
//  Created by Yale的Mac on 2017/2/28.
//  Copyright © 2017年 YaleMac. All rights reserved.
//

import UIKit
import EasyPeasy



class RestaurantTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle,reuseIdentifier reuseIdentifire: String?){
        
        super.init(style: style, reuseIdentifier: reuseIdentifire)
        
        
        
        
        setUpViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    lazy var restaurantImageView:UIImageView={
        
        return UIImageView()
        
    }()
    
    
    
    lazy var restaurantName : UILabel={
        
        
        let rN=UILabel()
        
        
        rN.text="Restaurant Name"
        rN.font=RestaurantListSize.restaurantName
        rN.textColor=RestaurantListColor.restaurantNameColor
        
        
        return rN
        
        
    }()
    
    
    
    lazy var restaurantAddress: UILabel={
        
        
        let rA=UILabel()
        
        
        rA.text="Hwy 7"
        rA.font=RestaurantListSize.restaurantAddress
        rA.textColor=RestaurantListColor.restaurantAddressColor
        
        return rA
        
        
    }()
    
    
    
    lazy var restaurantDist: UILabel={
        
        
        let rD=UILabel()
        
        rD.text="0.3km"
        rD.font=RestaurantListSize.restaurantDist
        rD.textColor=RestaurantListColor.restaurantDistColor
        
        
        
        return rD
        
        
    }()
    
    
    
    lazy var restaurantPrice: UILabel={
        
        
        let rP=UILabel()
        
        
        rP.text="$$$999"
        rP.font=RestaurantListSize.restaurantPrice
        rP.textColor=RestaurantListColor.restaurantPriceColor
        
        
        
        
        return rP
        
        
    }()
    
    
    
    lazy var restaurantCategory: UILabel={
        
        
        let rC=UILabel()
        
        
        rC.text="Salad,Pizza"
        rC.font=RestaurantListSize.restaurantCategory
        rC.textColor=RestaurantListColor.restaurantCategoryColor
        
        
        
        return rC
        
        
    }()
    
    
    
    lazy var cellDistance:UIImageView={
        
        var subFrame = CGRect()
        
        
        let cD=UIImageView(frame:subFrame)
        
        return cD
        
    }()
    
    
    
    
    lazy var promotionRateView:UIImageView={
        
        var subFrame = CGRect()
        
        
        let pR=UIImageView(/*frame:subFrame*/)
        
        return pR
        
    }()
    
    
    
    
    
    
    lazy var promotionRate:UILabel={
        
        var subFrame = CGRect()
        
        
        
        let  pR = UILabel(/*frame: subFrame*/)
        
        
        pR.text="Specials: 15% OFF"
        pR.textAlignment=NSTextAlignment.center
        pR.font=RestaurantListSize.promotionRate
        pR.textColor=RestaurantListColor.promotionRateColor
        
        
        return pR
        
    }()
    
    
    
    
    
    lazy var addGroupButton:UIButton={
        
        let aGB=UIButton()
        aGB.setBackgroundImage(UIImage(named:"lable-01.png"), for: .normal)
        
        return aGB
        
    }()
    
    func setUpViews(){
        
        
        
        
        restaurantImageView.backgroundColor=UIColor.brown
        
        
        restaurantImageView <- [
            
            Height(RestaurantListSpace.restaurantImageViewHeight),
            Width(RestaurantListSpace.restaurantImageViewWidth)]
        
        restaurantImageView<-[
            
            Top().to(contentView),
            Left().to(contentView,.left)
            
        ]
        
        self.contentView.addSubview(restaurantImageView)
        
        
        
        
        
        
        
        
        self.contentView.addSubview(restaurantName)
        
        restaurantName<-[
            Top(RestaurantListSpace.restaurantNameTopPadding).to(contentView),
            Leading(RestaurantListSpace.imageLabelPadding).to(restaurantImageView,.trailing)
        ]
        
        
        
        
        
        
        
        
        self.contentView.addSubview(restaurantAddress)
        
        restaurantAddress<-[
            Top(RestaurantListSpace.imageLabelPadding).to(restaurantName),
            Leading(RestaurantListSpace.imageLabelPadding).to(restaurantImageView,.trailing)
        ]
        
        
        
        
        
        
        
        self.contentView.addSubview(restaurantDist)
        
        restaurantDist<-[
            
            Top(RestaurantListSpace.distNamePadding).to(restaurantAddress),
            Leading(RestaurantListSpace.imageLabelPadding).to(restaurantImageView,.trailing)
            
        ]
        
        
        
        
        
        
        
        
        self.contentView.addSubview(restaurantPrice)
        
        restaurantPrice<-[
            
            Top(RestaurantListSpace.distNamePadding).to(restaurantAddress),
            Leading(RestaurantListSpace.imagePricePadding).to(restaurantImageView,.trailing)
            
        ]
        
        
        
        
        
        
        
        
        self.contentView.addSubview(restaurantCategory)
        
        restaurantCategory<-[
            
            
            Leading(RestaurantListSpace.imageLabelPadding).to(restaurantImageView,.trailing),
            Bottom(RestaurantListSpace.restaurantCategoryButtomPadding).to(contentView)
            
            
        ]
        
        
        
        
        cellDistance.backgroundColor=UIColor.white
        self.contentView.addSubview(cellDistance)
        
        
        
        cellDistance <- Height(CGFloat(RestaurantListSpace.cellDistanceSpaceHeight))
        
        
        cellDistance<-[
            
            Leading(0).to(contentView,.leading),
            Trailing(0).to(contentView,.trailing),
            Top(0).to(restaurantImageView,.bottom)
            
            
        ]
        
        
        
        
        
        
        
        
        
        promotionRateView.backgroundColor=UIColor.black
        self.contentView.addSubview(promotionRateView)
        
        
        promotionRateView<-[
            
            Height(CGFloat(RestaurantListSpace.promotionRateViewHeight)),
            
            Width(CGFloat(RestaurantListSpace.promotionRateViewWidth))
            
            
        ]
        
        
        promotionRateView<-[
            
            Trailing(0).to(restaurantImageView,.trailing),
            Bottom(RestaurantListSpace.restaurantCategoryButtomPadding).to(contentView,.bottom)
            
            
            
        ]
        
        
        
        
        promotionRateView.addSubview(promotionRate)
        
        promotionRate<-[
            
            Center(CGPoint(x: 0, y: 0))
            
            
        ]
        
        
        
        
        self.contentView.addSubview(addGroupButton)
        
        
        addGroupButton<-[
            
            Trailing(RestaurantListSpace.buttonRightPadding).to(contentView),
            
            Bottom(RestaurantListSpace.restaurantCategoryButtomPadding).to(contentView)
            
        ]
        
        addGroupButton<-[
            
            Height(RestaurantListSpace.addGroupButtonSize),
            
            Width(RestaurantListSpace.addGroupButtonSize)
            
        ]
        
        
        
    }
}
