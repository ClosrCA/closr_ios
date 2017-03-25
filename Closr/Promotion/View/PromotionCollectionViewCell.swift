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
    
    func update(promotion: Promotion) {
        
        thumbnailImageView.loadImage(URLString: promotion.imageURL, placeholder: nil)
        
        nameLabel.text      = promotion.resturantName
        distanceLabel.text  = promotion.distance
        
        promotionContainerView.updateWith(promotion: promotion)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(locationIconImageView)
        contentView.addSubview(distanceLabel)
        contentView.addSubview(promotionContainerView)
        
        createConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate lazy var thumbnailImageView: UIImageView = {
        let imageView                                       = UIImageView()
        imageView.backgroundColor                           = AppColor.greyBackground
        
        return imageView
    }()
    
    fileprivate lazy var locationIconImageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    fileprivate lazy var nameLabel: UILabel = UILabel.makeLable(font: AppFont.thinTitle, textColor: AppColor.title)
    
    fileprivate lazy var distanceLabel: UILabel = UILabel.makeLable(font: AppFont.smallText, textColor: AppColor.greyText)
    
    fileprivate lazy var promotionContainerView: PromotionContainerView = PromotionContainerView(frame: .zero)
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        thumbnailImageView.af_cancelImageRequest()
        thumbnailImageView.image    = nil
        nameLabel.text              = nil
        distanceLabel.text          = nil
        
        promotionContainerView.prepareForReuse()
    }
    
    fileprivate func createConstraints() {
        
        thumbnailImageView <- [
            Leading(),
            Top(),
            Trailing(),
            Height(floor(frame.width / PromotionListConstant.Cell.imageAspectRatio))
        ]
        
        nameLabel <- [
            Leading(),
            Top(PromotionListConstant.Cell.nameTopPadding).to(thumbnailImageView, .bottom),
            Trailing().to(promotionContainerView, .leading),
            Bottom(PromotionListConstant.Cell.nameBottomPadding).to(distanceLabel, .top)
        ]
        
        locationIconImageView <- [
            Size(20),
            Leading(),
            Top().to(distanceLabel, .top)
        ]
        
        distanceLabel <- [
            Leading().to(locationIconImageView, .trailing),
            Trailing(>=0).to(promotionContainerView, .leading)
        ]
        
        promotionContainerView <- [
            Height(PromotionListConstant.Cell.promotionLabelHeight),
            Width(PromotionListConstant.Cell.promotionLabelWidth),
            Bottom().to(distanceLabel, .bottom),
            Trailing()
        ]
    }
}
