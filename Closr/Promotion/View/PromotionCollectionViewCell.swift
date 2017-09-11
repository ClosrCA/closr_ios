//
//  PromotionCollectionViewCell.swift
//  Closr
//
//  Created by Tao on 2017-02-16.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit
import EasyPeasy

class PromotionCollectionViewCell: UICollectionViewCell, Reusable {
    
    static let preferredSize: CGSize = CGSize(width: 295, height: 170)
    
    fileprivate struct Constants {
        static let backgroundHeight: CGFloat = 92
    }
    
    fileprivate lazy var backgroundImageView: UIImageView = {
        let imageView                   = UIImageView()
        imageView.layer.cornerRadius    = 4
        imageView.clipsToBounds         = true
        
        return imageView
    }()
    
    fileprivate lazy var backgroundOverlay: UIImageView = {
        let imageView   = UIImageView()
        imageView.image = UIImage(named: "promotion_overlay")
        
        return imageView
    }()
    
    fileprivate lazy var restaurantNameLabel: UILabel = UILabel.makeLabel(font: AppFont.title, textColor: AppColor.text_light)
    
    fileprivate lazy var distanceLabel: UILabel = UILabel.makeLabel(font: AppFont.smallText, textColor: AppColor.text_light)
    
    fileprivate lazy var locationIconImageView: UIImageView = {
        let imageView   = UIImageView()
        imageView.image = UIImage(named: "icon_location")
        
        return imageView
    }()
    
    fileprivate lazy var timeIconImageView: UIImageView = {
        let imageView   = UIImageView()
        imageView.image = UIImage(named: "icon_time")
        
        return imageView
    }()
    
    fileprivate lazy var durationLabel: UILabel = UILabel.makeLabel(font: AppFont.smallText, textColor: AppColor.text_dark)
    
    fileprivate lazy var locationLabel: UILabel = UILabel.makeLabel(font: AppFont.smallText, textColor: AppColor.text_gray)
    
    fileprivate lazy var promotionContainerView: PromotionContainerView = PromotionContainerView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.layer.cornerRadius  = 4
        contentView.layer.borderColor   = AppColor.background_brand.cgColor
        contentView.layer.borderWidth   = 1
        contentView.clipsToBounds       = true
        
        contentView.addSubview(backgroundImageView)
        contentView.addSubview(backgroundOverlay)
        contentView.addSubview(restaurantNameLabel)
        contentView.addSubview(distanceLabel)
        
        contentView.addSubview(locationIconImageView)
        contentView.addSubview(timeIconImageView)
        contentView.addSubview(durationLabel)
        contentView.addSubview(locationLabel)
        contentView.addSubview(promotionContainerView)
        
        createConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(promotion: Promotion) {
        
        backgroundImageView.loadImage(URLString: promotion.imageURL, placeholder: nil)
        
        restaurantNameLabel.text    = promotion.resturantName
        locationLabel.text          = promotion.address
        distanceLabel.text          = promotion.distance
        durationLabel.text          = promotion.duration
        
        promotionContainerView.updateWith(promotion: promotion)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        backgroundImageView.af_cancelImageRequest()
        backgroundImageView.image   = nil
        restaurantNameLabel.text    = nil
        distanceLabel.text          = nil
        locationLabel.text          = nil
        durationLabel.text          = nil
        
        promotionContainerView.prepareForReuse()
    }
    
    fileprivate func createConstraints() {
        
        backgroundImageView <- [
            Top(AppSizeMetric.defaultPadding),
            Leading(AppSizeMetric.defaultPadding),
            Trailing(AppSizeMetric.defaultPadding),
            Height(Constants.backgroundHeight)
        ]
        
        backgroundOverlay <- [
            Top(AppSizeMetric.defaultPadding),
            Leading(AppSizeMetric.defaultPadding),
            Trailing(AppSizeMetric.defaultPadding),
            Height(Constants.backgroundHeight)
        ]
        
        restaurantNameLabel <- [
            Leading(AppSizeMetric.breathPadding),
            Bottom(AppSizeMetric.defaultPadding).to(backgroundImageView, .bottom)
        ]
        
        distanceLabel <- [
            Trailing(AppSizeMetric.breathPadding),
            Bottom().to(restaurantNameLabel, .bottom)
        ]
        
        timeIconImageView <- [
            Leading(AppSizeMetric.defaultPadding),
            Top(AppSizeMetric.defaultPadding).to(backgroundImageView),
            Size(AppSizeMetric.iconSize)
        ]
        
        locationIconImageView <- [
            Leading(AppSizeMetric.defaultPadding),
            Top(AppSizeMetric.defaultPadding).to(timeIconImageView),
            Size(AppSizeMetric.iconSize)
        ]
        
        durationLabel <- [
            Leading(AppSizeMetric.defaultPadding).to(timeIconImageView),
            CenterY().to(timeIconImageView)
        ]
        
        locationLabel <- [
            Leading(AppSizeMetric.defaultPadding).to(locationIconImageView),
            CenterY().to(locationIconImageView)
        ]
        
        promotionContainerView <- [
            Size(50),
            Trailing(AppSizeMetric.breathPadding),
            Bottom(AppSizeMetric.breathPadding)
        ]
    }
}
