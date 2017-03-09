//
//  RestaurantTableViewCell.swift
//  TableViewTest
//
//  Created by Yale的Mac on 2017/2/28.
//  Copyright © 2017年 YaleMac. All rights reserved.
//

import UIKit
import EasyPeasy

struct restaurantInformation {
    
    
    var restaurantName=String()
    var restaurantAddress=String()
    var restaurantDist=String()
    var restaurantPrice=String()
    var restaurantCategory=String()
    
    
    
}

class RestaurantTableViewCell: UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override init(style: UITableViewCellStyle,reuseIdentifier reuseIdentifire: String?){
        
        super.init(style: style, reuseIdentifier: reuseIdentifire)
        
        
        
        
        setUpViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func setUpViews(){
        
        
        
        var subFrame = CGRect()
        
        
        /*
         subFrame.origin.x = CGFloat(RestaurantFontSpace.restaurantImageViewSpace.originX)
         subFrame.origin.y = CGFloat(RestaurantFontSpace.restaurantImageViewSpace.originY)
         subFrame.size.width = CGFloat(RestaurantFontSpace.restaurantImageViewSpace.sizeWidth)
         subFrame.size.height = CGFloat(RestaurantFontSpace.restaurantImageViewSpace.sizeHeight)
         
         */
        let  restaurantImageView = UIImageView()
        restaurantImageView.backgroundColor=UIColor.brown
        
        
        restaurantImageView <- [
            Height(CGFloat(RestaurantFontSpace.restaurantImageViewSpace.sizeHeight)),
            Width(CGFloat(RestaurantFontSpace.restaurantImageViewSpace.sizeWidth))]
        
        restaurantImageView<-[
            
            Top().to(contentView),
            Left().to(contentView,.left)
            
            
        ]
        
        
        self.contentView.addSubview(restaurantImageView)
        
        
        
        
        //RestaurantName
        /*
         
         subFrame.origin.x = CGFloat(RestaurantFontSpace.restaurantNameSpace.originX)
         subFrame.origin.y = CGFloat(RestaurantFontSpace.restaurantNameSpace.originY)
         subFrame.size.width = CGFloat(RestaurantFontSpace.restaurantNameSpace.sizeWidth)
         subFrame.size.height = CGFloat(RestaurantFontSpace.restaurantNameSpace.sizeHeight)*/
        
        let  restaurantName = UILabel()
        restaurantName.text="Restaurant Name"
        restaurantName.font=RestaurantFontSize.restaurantNameSize
        restaurantName.textColor=RestaurantFontColor.restaurantNameColor
        
        self.contentView.addSubview(restaurantName)
        
        restaurantName<-[
            Top(RestaurantFontSpace.restaurantTopSpace).to(contentView),
            Leading(RestaurantFontSpace.imageLabelSpace).to(restaurantImageView,.trailing)
        ]
        
        
        
        //RestaurantAddress
        
        
        /* subFrame.origin.x = CGFloat(RestaurantFontSpace.restaurantAddressSpace.originX)
         subFrame.origin.y = CGFloat(RestaurantFontSpace.restaurantAddressSpace.originY)
         subFrame.size.width = CGFloat(RestaurantFontSpace.restaurantAddressSpace.sizeWidth)
         subFrame.size.height = CGFloat(RestaurantFontSpace.restaurantAddressSpace.sizeHeight)*/
        let  restaurantAddress = UILabel()
        restaurantAddress.text="Hwy 7"
        restaurantAddress.font=RestaurantFontSize.restaurantAddressSize
        restaurantAddress.textColor=RestaurantFontColor.restaurantAddressColor
        self.contentView.addSubview(restaurantAddress)
        
        restaurantAddress<-[
            Top(RestaurantFontSpace.imageLabelSpace).to(restaurantName),
            Leading(RestaurantFontSpace.imageLabelSpace).to(restaurantImageView,.trailing)
        ]
        
        
        
        //RestaurantDist
        
        
        
        /*  subFrame.origin.x = CGFloat(RestaurantFontSpace.restaurantDistSpace.originX)
         subFrame.origin.y = CGFloat(RestaurantFontSpace.restaurantDistSpace.originY)
         subFrame.size.width = CGFloat(RestaurantFontSpace.restaurantDistSpace.sizeWidth)
         subFrame.size.height = CGFloat(RestaurantFontSpace.restaurantDistSpace.sizeHeight)*/
        let  restaurantDist = UILabel()
        restaurantDist.text="0.3km"
        restaurantDist.font=RestaurantFontSize.restaurantDistSize
        restaurantDist.textColor=RestaurantFontColor.restaurantDistColor
        self.contentView.addSubview(restaurantDist)
        
        restaurantDist<-[
            
            Top(RestaurantFontSpace.distNameSpace).to(restaurantAddress),
            Leading(RestaurantFontSpace.imageLabelSpace).to(restaurantImageView,.trailing)
            
        ]
        
        
        //RestaurantPrice
        
        /*
         subFrame.origin.x = CGFloat(RestaurantFontSpace.restaurantPriceSpace.originX)
         subFrame.origin.y = CGFloat(RestaurantFontSpace.restaurantPriceSpace.originY)
         subFrame.size.width = CGFloat(RestaurantFontSpace.restaurantPriceSpace.sizeWidth)
         subFrame.size.height = CGFloat(RestaurantFontSpace.restaurantPriceSpace.sizeHeight)*/
        let  restaurantPrice = UILabel()
        restaurantPrice.text="$$$999"
        restaurantPrice.font=RestaurantFontSize.restaurantPriceSize
        restaurantPrice.textColor=RestaurantFontColor.restaurantPriceColor
        self.contentView.addSubview(restaurantPrice)
        
        
        restaurantPrice<-[
            
            Top(RestaurantFontSpace.distNameSpace).to(restaurantAddress),
            Leading(RestaurantFontSpace.imagePriceSpace).to(restaurantImageView,.trailing)
            
        ]
        
        
        
        //restaurantCategory
        
        
        /* subFrame.origin.x = CGFloat(RestaurantFontSpace.restaurantCategorySpace.originX)
         subFrame.origin.y = CGFloat(RestaurantFontSpace.restaurantCategorySpace.originY)
         subFrame.size.width = CGFloat(RestaurantFontSpace.restaurantCategorySpace.sizeWidth)
         subFrame.size.height = CGFloat(RestaurantFontSpace.restaurantCategorySpace.sizeHeight)*/
        let  restaurantCategory = UILabel()
        restaurantCategory.text="Salad,Pizza"
        restaurantCategory.font=RestaurantFontSize.restaurantCategorySize
        restaurantCategory.textColor=RestaurantFontColor.restaurantCategoryColor
        self.contentView.addSubview(restaurantCategory)
        
        restaurantCategory<-[
            
            // Top(RestaurantFontSpace.categoryTopSpace).to(restaurantDist),
            Leading(RestaurantFontSpace.imageLabelSpace).to(restaurantImageView,.trailing),
            Bottom(RestaurantFontSpace.categoryButtomSpace).to(contentView)
            
            
        ]
        
        
        
        
        //cellDistance
        
        subFrame.origin.x = CGFloat(RestaurantFontSpace.cellDistanceSpace.originX)
        subFrame.origin.y = CGFloat(RestaurantFontSpace.cellDistanceSpace.originY)
        subFrame.size.width = CGFloat(RestaurantFontSpace.cellDistanceSpace.sizeWidth)
        subFrame.size.height = CGFloat(RestaurantFontSpace.cellDistanceSpace.sizeHeight)
        let  cellDistance = UIImageView(frame: subFrame)
        cellDistance.backgroundColor=UIColor.white
        self.contentView.addSubview(cellDistance)
        
        
        //promotionRateView
        
        subFrame.origin.x = CGFloat(RestaurantFontSpace.promotionRateViewSpace.originX)
        subFrame.origin.y = CGFloat(RestaurantFontSpace.promotionRateViewSpace.originY)
        subFrame.size.width = CGFloat(RestaurantFontSpace.promotionRateViewSpace.sizeWidth)
        subFrame.size.height = CGFloat(RestaurantFontSpace.promotionRateViewSpace.sizeHeight)
        let  promotionRateView = UIImageView(frame: subFrame)
        promotionRateView.backgroundColor=UIColor.black
        self.contentView.addSubview(promotionRateView)
        
        
        
        //promotionRate
        
        
        let  promotionRate = UILabel(frame: subFrame)
        promotionRate.text="Specials: 15% OFF"
        promotionRate.textAlignment=NSTextAlignment.center
        promotionRate.font=RestaurantFontSize.promotionRateSize
        promotionRate.textColor=RestaurantFontColor.promotionRateColor
        self.contentView.addSubview(promotionRate)
        
        
        
        //addGroupButton
        
        /*
         subFrame.origin.x = CGFloat(RestaurantFontSpace.addGroupButtonSpace.originX)
         subFrame.origin.y = CGFloat(RestaurantFontSpace.addGroupButtonSpace.originY)
         subFrame.size.width = CGFloat(RestaurantFontSpace.addGroupButtonSpace.sizeWidth)
         subFrame.size.height = CGFloat(RestaurantFontSpace.addGroupButtonSpace.sizeHeight)
         */
        let addGroupButton=UIButton(frame: subFrame)
        addGroupButton.setBackgroundImage(UIImage(named:"lable-01.png"), for: .normal)
        
        self.contentView.addSubview(addGroupButton)
        
        
        addGroupButton<-[
            
            Trailing(RestaurantFontSpace.buttonRightSpace).to(contentView),
            
            Bottom(RestaurantFontSpace.categoryButtomSpace).to(contentView)
            
        ]
        addGroupButton<-[
            
            Height(CGFloat(RestaurantFontSpace.addGroupButtonSpace.sizeHeight)),
            
            Width(CGFloat(RestaurantFontSpace.addGroupButtonSpace.sizeWidth))
            
        ]
        
        
        
    }
}
