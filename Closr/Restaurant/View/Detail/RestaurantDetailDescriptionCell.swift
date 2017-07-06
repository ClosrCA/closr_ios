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
        let nameLabel            = UILabel.makeLabel(font: AppFont.largeTitle, textColor: AppColor.title)
        nameLabel.numberOfLines  = 0
        
        return nameLabel
    }()
    
    fileprivate lazy var reviewBackground: UIView   = UIView()
    fileprivate lazy var cuisineLabel: UILabel      = UILabel.makeLabel(font: AppFont.smallText, textColor: AppColor.brand)
    
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
        let review = ReviewHelper.buildReviewView(rating: rating, scoreImage: UIImage(named: "review_star"), halfScoreImage: UIImage(named: "review_star_half"))
        
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
        
        
    }
}
