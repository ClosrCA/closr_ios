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
        let imageView                   = UIImageView()
        imageView.backgroundColor       = UIColor.lightGray
        imageView.layer.cornerRadius    = RestaurantListConstant.Restaurant.imageCornerRadius
        imageView.clipsToBounds         = true
        
        return imageView
    }()
    
    fileprivate lazy var reviewImageView: UIImageView = UIImageView()
    
    fileprivate lazy var nameLabel: UILabel = UILabel.makeLabel(font: AppFont.thinTitle, textColor: AppColor.brand)
    
    fileprivate lazy var addressLabel: UILabel = UILabel.makeLabel(font: AppFont.smallText, textColor: AppColor.greyText)
    
    fileprivate lazy var distanceLabel: UILabel = UILabel.makeLabel(font: AppFont.smallText, textColor: AppColor.greyText)
    
    fileprivate lazy var priceLabel: UILabel = UILabel.makeLabel(font: AppFont.smallText, textColor: AppColor.title)
    
    fileprivate lazy var categoryLabel: UILabel = UILabel.makeLabel(font: AppFont.smallText, textColor: AppColor.title)
    
    
    func update(restaurant: YelpPlace, placeHolder: UIImage?, promoted: Bool) {
        restaurantImageView.loadImage(URLString: restaurant.imageURL, placeholder: nil)
        nameLabel.text = restaurant.name
        addressLabel.text = restaurant.address?.displayAddress?.first
        distanceLabel.text = restaurant.distance?.readableDescription
        priceLabel.text = restaurant.price
        categoryLabel.text = restaurant.categories?.first?.title
        
        if let rating = restaurant.rating {
            reviewImageView.image = ReviewHelper.buildYelpSmallReview(rating: rating)
        }
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
        
        reviewImageView.image = nil
    }
    
    fileprivate func setUpViews() {
        contentView.addSubview(reviewImageView)
        contentView.addSubview(restaurantImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(addressLabel)
        contentView.addSubview(distanceLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(categoryLabel)
    }
    
    fileprivate func createConstraints() {
        
        restaurantImageView <- [
            Size(RestaurantListConstant.Restaurant.imageSize),
            Top(RestaurantListConstant.Restaurant.imagePadding),
            Leading(RestaurantListConstant.Restaurant.imagePadding),
            Bottom(RestaurantListConstant.Restaurant.imagePadding)
        ]
        
        nameLabel <- [
            Top(RestaurantListConstant.Restaurant.restaurantNameTopPadding),
            Leading(RestaurantListConstant.Restaurant.resaurantNameHorizontalPadding).to(restaurantImageView),
            Trailing(RestaurantListConstant.Restaurant.resaurantNameHorizontalPadding)
        ]
        
        categoryLabel <- [
            Leading().to(nameLabel, .leading),
            Trailing().to(nameLabel, .trailing),
            Top(RestaurantListConstant.Restaurant.verticalPadding).to(nameLabel)
        ]
        
        addressLabel <- [
            Top(RestaurantListConstant.Restaurant.verticalPadding).to(categoryLabel),
            Leading().to(nameLabel, .leading),
            Trailing().to(nameLabel, .trailing)
        ]
        
        reviewImageView <- [
            Size(RestaurantListConstant.Restaurant.reviewSize),
            Leading().to(nameLabel, .leading),
            Top(RestaurantListConstant.Restaurant.verticalPadding).to(addressLabel)
        ]
        
        priceLabel <- [
            Top(RestaurantListConstant.Restaurant.verticalPadding).to(reviewImageView),
            Leading().to(nameLabel, .leading)
        ]
        
        distanceLabel <- [
            Top(RestaurantListConstant.Restaurant.verticalPadding).to(priceLabel),
            Leading().to(nameLabel,.leading)
        ]
    }
}
