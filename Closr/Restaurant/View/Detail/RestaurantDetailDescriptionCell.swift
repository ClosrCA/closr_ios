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

    struct Constatns {
        static let verticalPadding: CGFloat = 10
        static let horizontalPadding: CGFloat = 20
        
        static let ratingImageSize: CGSize = CGSize(width: 102, height: 18)
        static let infoLeftPadding: CGFloat = Device.screenWidth / 5
    }
    
    fileprivate lazy var nameLabel: UILabel = {
        let nameLabel            = UILabel.makeLabel(font: AppFont.largeTitle, textColor: AppColor.title)
        nameLabel.numberOfLines  = 0
        
        return nameLabel
    }()
    
    fileprivate lazy var reviewImageView: UIImageView   = UIImageView()
    fileprivate lazy var cuisineLabel: UILabel          = UILabel.makeLabel(font: AppFont.smallText, textColor: AppColor.brand)
    
    fileprivate lazy var openHoursTitleLabel: UILabel = UILabel.makeLabel(font: AppFont.smallText, textColor: AppColor.brand, text: "Open hours:")
    fileprivate lazy var phoneTitleLabel: UILabel     = UILabel.makeLabel(font: AppFont.smallText, textColor: AppColor.brand, text: "Phone:")
    fileprivate lazy var addressTitleLabel: UILabel   = UILabel.makeLabel(font: AppFont.smallText, textColor: AppColor.brand, text: "Address:")
    
    fileprivate lazy var openHoursLabel: UILabel    = UILabel.makeLabel(font: AppFont.smallText, textColor: AppColor.greyText)
    fileprivate lazy var phoneLabel: UILabel        = UILabel.makeLabel(font: AppFont.smallText, textColor: AppColor.greyText)
    fileprivate lazy var addressLabel: UILabel      = UILabel.makeLabel(font: AppFont.smallText, textColor: AppColor.greyText)
    
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
        
        
        let ratingImage = UIImage(named: ReviewHelper.yelpRegularReviewImageName(rating: restaurant.rating ?? 0))
        reviewImageView.image = ratingImage
        
        // TODO: open hours parsing
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        buildSubViews()
        
        createConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func buildSubViews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(reviewImageView)
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
            Leading(Constatns.horizontalPadding),
            Trailing(Constatns.horizontalPadding),
            Top(Constatns.verticalPadding)
        ]
        
        reviewImageView <- [
            Size(Constatns.ratingImageSize),
            Top(Constatns.verticalPadding).to(nameLabel),
            CenterX()
        ]
        
        cuisineLabel <- [
            Leading(Constatns.horizontalPadding),
            Trailing(Constatns.horizontalPadding),
            Top(Constatns.verticalPadding).to(reviewImageView)
        ]
        
        openHoursTitleLabel <- [
            Leading(Constatns.infoLeftPadding),
            Top(Constatns.verticalPadding).to(cuisineLabel)
        ]
        
        openHoursLabel <- [
            Leading(Constatns.horizontalPadding).to(openHoursTitleLabel),
            Trailing(<=Constatns.horizontalPadding),
            CenterY().to(openHoursTitleLabel)
        ]
        
        phoneTitleLabel <- [
            Trailing().to(openHoursTitleLabel, .trailing),
            Top(Constatns.verticalPadding).to(openHoursTitleLabel)
        ]
        
        phoneLabel <- [
            Leading(Constatns.horizontalPadding).to(phoneTitleLabel),
            Trailing(<=Constatns.horizontalPadding),
            CenterY().to(phoneTitleLabel)
        ]
        
        addressTitleLabel <- [
            Trailing().to(openHoursTitleLabel, .trailing),
            Top(Constatns.verticalPadding).to(phoneTitleLabel),
            Bottom(Constatns.verticalPadding)
        ]
        
        addressLabel <- [
            Leading(Constatns.horizontalPadding).to(addressTitleLabel),
            Trailing(<=Constatns.horizontalPadding),
            CenterY().to(addressTitleLabel)
        ]
    }
}
