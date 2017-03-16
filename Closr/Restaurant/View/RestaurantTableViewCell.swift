//
//  RestaurantTableViewCell.swift
//  Closr
//
//  Created by Yale的Mac on 2017/2/28.
//  Copyright © 2017年 YaleMac. All rights reserved.
//

import UIKit
import EasyPeasy

class RestaurantTableViewCell: UITableViewCell, Reusable {
    
    fileprivate lazy var restaurantImageView: UIImageView = {
        let imageView               = UIImageView()
        imageView.backgroundColor   = UIColor.lightGray
        
        return imageView
    }()
    
    fileprivate lazy var nameLabel: UILabel = {
        let label       = UILabel()
        label.text      = "Restaurant Name"
        label.font      = RestaurantListFont.restaurantName
        label.textColor = RestaurantListColor.restaurantName
        
        return label
    }()
    
    fileprivate lazy var addressLabel: UILabel = {
        let label       = UILabel()
        label.text      = "Hwy 7, 2031"
        label.font      = RestaurantListFont.address
        label.textColor = RestaurantListColor.address
        
        return label
    }()
    
    fileprivate lazy var distanceLabel: UILabel = {
        let label       = UILabel()
        label.text      = "2.3km"
        label.font      = RestaurantListFont.distance
        label.textColor = RestaurantListColor.distance
        
        return label
    }()
    
    fileprivate lazy var priceLabel: UILabel = {
        let label       = UILabel()
        label.text      = "$$$ 999"
        label.font      = RestaurantListFont.price
        label.textColor = RestaurantListColor.price
        
        return label
    }()
    
    fileprivate lazy var categoryLabel: UILabel = {
        let label       = UILabel()
        label.text      = "pizza, spagetti, rice"
        label.font      = RestaurantListFont.category
        label.textColor = RestaurantListColor.category
        
        return label
    }()
    
    fileprivate lazy var distanceImageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    fileprivate lazy var promotionBackgroundImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.backgroundColor=UIColor.orange
        
        return imageView
    }()
    
    fileprivate lazy var promotionLabel: UILabel = {
        let label       = UILabel()
        label.text      = "Specials: 15% OFF"
        label.font      = RestaurantListFont.promotionRate
        label.textColor = RestaurantListColor.promotionRate
        
        return label
    }()
    
    fileprivate lazy var addGroupButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named:"lable-01.png"), for: .normal)
        
        return button
    }()
    
    
     func update(restaurant: YelpPlace, placeHolder: UIImage?) {
     restaurantImageView.loadImage(URLString: restaurant.imageURL, placeholder: nil)
     }
    
    override init(style: UITableViewCellStyle,reuseIdentifier reuseIdentifire: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifire)
        
        setUpViews()
        createConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setUpViews() {
        
        contentView.addSubview(restaurantImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(addressLabel)
        contentView.addSubview(distanceLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(distanceImageView)
        
        contentView.addSubview(promotionBackgroundImageView)
        promotionBackgroundImageView.addSubview(promotionLabel)
        
        contentView.addSubview(addGroupButton)
        
        
    }
    
    fileprivate func createConstraints() {
        
        restaurantImageView <- [
            
            Height(RestaurantListConstant.restaurantImageViewHeight),
            Width(RestaurantListConstant.restaurantImageViewWidth),
            Top(RestaurantListConstant.restaurantContentTopPadding),
            Bottom(),
            Leading()
        ]
        
        nameLabel <- [
            
            Top(RestaurantListConstant.restaurantNameTopPadding+RestaurantListConstant.restaurantContentTopPadding),
            Leading(RestaurantListConstant.imageLabelPadding).to(restaurantImageView,.trailing)
        ]
        
        addressLabel <- [
            
            Top(RestaurantListConstant.imageLabelPadding).to(nameLabel),
            Leading(RestaurantListConstant.imageLabelPadding).to(restaurantImageView,.trailing)
        ]
        
        distanceLabel <- [
            
            Top(RestaurantListConstant.distNameTopPadding).to(addressLabel),
            Leading(RestaurantListConstant.imageLabelPadding).to(restaurantImageView,.trailing)
            
        ]
        
        priceLabel <- [
            
            Top(RestaurantListConstant.distNameTopPadding).to(addressLabel),
            Leading(RestaurantListConstant.imagePricePadding).to(restaurantImageView,.trailing)
        ]
        
        categoryLabel <- [
            
            Leading(RestaurantListConstant.imageLabelPadding).to(restaurantImageView,.trailing),
            Bottom(RestaurantListConstant.restaurantCategoryButtomPadding)
        ]
        
        distanceImageView <- [
            
            Leading(),
            Trailing(),
            Top().to(restaurantImageView,.bottom),
            Height(RestaurantListConstant.cellDistanceSpaceHeight)
        ]
        
        
        promotionBackgroundImageView <- [
            
            Height(RestaurantListConstant.promotionRateViewHeight),
            Width(RestaurantListConstant.promotionRateViewWidth),
            Trailing().to(restaurantImageView,.trailing),
            Bottom(RestaurantListConstant.restaurantCategoryButtomPadding)
        ]
        
        
        promotionLabel <- Center()
        
        
        
        addGroupButton <- [
            
            Trailing(RestaurantListConstant.buttonRightPadding),
            Bottom(RestaurantListConstant.restaurantCategoryButtomPadding),
            Height(RestaurantListConstant.addGroupButtonSize),
            Width(RestaurantListConstant.addGroupButtonSize)
        ]
        
    }
}
