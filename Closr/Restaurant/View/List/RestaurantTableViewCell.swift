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
        label.font      = RestaurantListFont.restaurantName
        label.textColor = RestaurantListColor.restaurantName
        
        return label
    }()
    
    fileprivate lazy var addressLabel: UILabel = {
        let label       = UILabel()
        label.font      = RestaurantListFont.address
        label.textColor = RestaurantListColor.address
        
        return label
    }()
    
    fileprivate lazy var distanceLabel: UILabel = {
        let label       = UILabel()
        label.font      = RestaurantListFont.distance
        label.textColor = RestaurantListColor.distance
        
        return label
    }()
    
    fileprivate lazy var priceLabel: UILabel = {
        let label       = UILabel()
        label.font      = RestaurantListFont.price
        label.textColor = RestaurantListColor.price
        
        return label
    }()
    
    fileprivate lazy var categoryLabel: UILabel = {
        let label       = UILabel()
        label.font      = RestaurantListFont.category
        label.textColor = RestaurantListColor.category
        
        return label
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
    
    
    func update(restaurant: YelpPlace, placeHolder: UIImage?, promoted: Bool) {
        restaurantImageView.loadImage(URLString: restaurant.imageURL, placeholder: nil)
        nameLabel.text = restaurant.name
        addressLabel.text = restaurant.address?.displayAddress?.first
        distanceLabel.text = restaurant.distance?.readableDescription
        priceLabel.text = restaurant.price
        categoryLabel.text = restaurant.categories?.first?.title
        
        promotionBackgroundImageView.isHidden = !promoted
     }
    
    override init(style: UITableViewCellStyle,reuseIdentifier reuseIdentifire: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifire)
        
        selectionStyle = .none
        
        setUpViews()
        createConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        restaurantImageView.af_cancelImageRequest()
        restaurantImageView.image = nil
    }
    
    fileprivate func setUpViews() {
        
        contentView.addSubview(restaurantImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(addressLabel)
        contentView.addSubview(distanceLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(categoryLabel)
        
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
            
            Top(RestaurantListConstant.restaurantNameTopPadding + RestaurantListConstant.restaurantContentTopPadding),
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
        
        promotionBackgroundImageView <- [
            
            Height(RestaurantListConstant.promotionRateViewHeight),
            Width(RestaurantListConstant.promotionRateViewWidth),
            Trailing().to(restaurantImageView,.trailing),
            Bottom(RestaurantListConstant.restaurantCategoryButtomPadding)
        ]
        
        promotionLabel <- Edges()
        
        addGroupButton <- [
            
            Trailing(RestaurantListConstant.buttonRightPadding),
            Bottom(RestaurantListConstant.restaurantCategoryButtomPadding),
            Height(RestaurantListConstant.addGroupButtonSize),
            Width(RestaurantListConstant.addGroupButtonSize)
        ]
    }
}
