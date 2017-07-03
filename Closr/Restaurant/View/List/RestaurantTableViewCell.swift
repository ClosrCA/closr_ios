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
    
    struct Constants {
        static let imageSize: CGSize                        = CGSize(width: 112, height: 144)
        static let reviewSize: CGSize                       = CGSize(width: 82, height: 14)
        static let imageCornerRadius: CGFloat               = 10
        static let imagePadding: CGFloat                    = 15
        static let restaurantNameTopPadding: CGFloat        = 20
        static let contentHorizontalPadding: CGFloat        = 13
        static let contentVerticalPadding: CGFloat          = 8
    }
    
    fileprivate lazy var restaurantImageView: UIImageView = {
        let imageView                   = UIImageView()
        imageView.backgroundColor       = UIColor.lightGray
        imageView.layer.cornerRadius    = Constants.imageCornerRadius
        imageView.contentMode           = .scaleAspectFill
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
            let imageName = ReviewHelper.yelpSmallReviewImageName(rating: rating)
            reviewImageView.image = UIImage(named: imageName)
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
            Size(Constants.imageSize),
            Top(Constants.imagePadding),
            Leading(Constants.imagePadding),
            Bottom(Constants.imagePadding)
        ]
        
        nameLabel <- [
            Top(Constants.restaurantNameTopPadding),
            Leading(Constants.contentHorizontalPadding).to(restaurantImageView),
            Trailing(<=Constants.contentHorizontalPadding)
        ]
        
        categoryLabel <- [
            Leading().to(nameLabel, .leading),
            Trailing(<=Constants.contentHorizontalPadding),
            Top(Constants.contentVerticalPadding).to(nameLabel)
        ]
        
        addressLabel <- [
            Top(Constants.contentVerticalPadding).to(categoryLabel),
            Leading().to(nameLabel, .leading),
            Trailing(<=Constants.contentHorizontalPadding)
        ]
        
        reviewImageView <- [
            Size(Constants.reviewSize),
            Leading().to(nameLabel, .leading),
            Top(Constants.contentVerticalPadding).to(addressLabel)
        ]
        
        priceLabel <- [
            Top(Constants.contentVerticalPadding).to(reviewImageView),
            Leading().to(nameLabel, .leading),
            Trailing(<=Constants.contentHorizontalPadding)
        ]
        
        distanceLabel <- [
            Top(Constants.contentVerticalPadding).to(priceLabel),
            Leading().to(nameLabel,.leading),
            Trailing(<=Constants.contentHorizontalPadding)
        ]
    }
}
