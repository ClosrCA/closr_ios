//
//  RestaurantDetailDescriptionCell.swift
//  Closr
//
//  Created by Tao on 2017-02-22.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit
import EasyPeasy

class RestaurantDetailDescriptionCell: UITableViewCell, Reusable {

    fileprivate lazy var nameLabel: UILabel = {
        let nameLabel            = UILabel.makeLable(font: AppFont.largeTitle, textColor: AppColor.title)
        nameLabel.numberOfLines  = 0
        
        return nameLabel
    }()
    
    fileprivate lazy var reviewBackground: UIView   = UIView()
    fileprivate lazy var cuisineLabel: UILabel      = UILabel.makeLable(font: AppFont.smallText, textColor: AppColor.brand)
    
    fileprivate lazy var openHoursTitleLabel: UILabel = UILabel.makeLable(font: AppFont.smallText, textColor: AppColor.brand, text: "Open hours:")
    fileprivate lazy var phoneTitleLabel: UILabel     = UILabel.makeLable(font: AppFont.smallText, textColor: AppColor.brand, text: "Phone:")
    fileprivate lazy var addressTitleLabel: UILabel   = UILabel.makeLable(font: AppFont.smallText, textColor: AppColor.brand, text: "Address:")
    
    fileprivate lazy var openHoursLabel: UILabel    = UILabel.makeLable(font: AppFont.smallText, textColor: AppColor.greyText)
    fileprivate lazy var phoneLabel: UILabel        = UILabel.makeLable(font: AppFont.smallText, textColor: AppColor.greyText)
    fileprivate lazy var addressLabel: UILabel      = UILabel.makeLable(font: AppFont.smallText, textColor: AppColor.greyText)
    
    func update(restaurant: YelpPlace) {
        nameLabel.text      = restaurant.name
        addressLabel.text   = restaurant.address?.displayAddress?.first
        phoneLabel.text     = restaurant.phone
        
        var cuisineAndPrice: String? = nil
        
        if let cuisine = restaurant.categories?.first?.title {
            cuisineAndPrice = cuisine
        }
        
        if cuisineAndPrice != nil && !cuisineAndPrice!.isEmpty {
            cuisineAndPrice?.append("   ")
        }
        
        if let price = restaurant.price {
            cuisineAndPrice?.append(price)
        }
        
        cuisineLabel.text = cuisineAndPrice
        
        if let rating = restaurant.rating {
            addReview(rating: rating)
        }
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        buildSubViews()
        
        createConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    fileprivate func addReview(rating: Double) {
        let review = ReviewFactory.reviewViewWith(rating: rating, scoreImage: UIImage(named: "review_star"), halfScoreImage: UIImage(named: "review_star_half"))
        
        reviewBackground <- Size(review.preferredSize)
        
        if let reviewView = review.reviewView {
            reviewBackground.addSubview(reviewView)
            
            reviewView <- Edges()
        }
    }
    
    fileprivate func buildSubViews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(reviewBackground)
        contentView.addSubview(cuisineLabel)
        contentView.addSubview(openHoursTitleLabel)
        contentView.addSubview(openHoursLabel)
        contentView.addSubview(phoneTitleLabel)
        contentView.addSubview(phoneLabel)
        contentView.addSubview(addressTitleLabel)
        contentView.addSubview(addressLabel)
    }
    
    fileprivate func createConstraints() {
        
        nameLabel <- [
            Leading(),
            Trailing(),
            Top(RestaurantDetailConstant.restaurantNameTopPadding)
        ]
        
        reviewBackground <- [
            Top(RestaurantDetailConstant.reviewTopPadding).to(nameLabel, .bottom),
            CenterX()
        ]
        
        cuisineLabel <- [
            Leading(),
            Trailing(),
            Top(RestaurantDetailConstant.cuisineTopPadding).to(reviewBackground, .bottom)
        ]
        
        openHoursTitleLabel <- [
            Top(RestaurantDetailConstant.infoSectionVerticalPadding).to(cuisineLabel, .bottom),
            Leading(RestaurantDetailConstant.infoSectionLeadingPadding)
        ]
        
        phoneTitleLabel <- [
            Top(RestaurantDetailConstant.infoInternalPadding).to(openHoursTitleLabel, .bottom),
            Trailing().to(openHoursTitleLabel, .trailing)
        ]
        
        addressTitleLabel <- [
            Top(RestaurantDetailConstant.infoInternalPadding).to(phoneTitleLabel, .bottom),
            Trailing().to(phoneTitleLabel, .trailing),
            Bottom(RestaurantDetailConstant.infoSectionVerticalPadding)
        ]
        
        openHoursLabel <- [
            Leading(8).to(openHoursTitleLabel, .trailing),
            Trailing(<=8),
            CenterY().to(openHoursTitleLabel, .centerY)
        ]
        
        phoneLabel <- [
            Leading(8).to(phoneTitleLabel, .trailing),
            Trailing(<=8),
            CenterY().to(phoneTitleLabel, .centerY)
        ]
        
        addressLabel <- [
            Leading(8).to(addressTitleLabel, .trailing),
            Trailing(<=8),
            CenterY().to(addressTitleLabel, .centerY),
        ]
    }
}
