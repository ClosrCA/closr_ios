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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(locationIconImageView)
        contentView.addSubview(distanceLabel)
        contentView.addSubview(promotionContainerView)
        
        contentView.backgroundColor = PromotionColor.primary
        
        createConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate lazy var thumbnailImageView: UIImageView = {
        let imageView                                       = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    fileprivate lazy var locationIconImageView: UIImageView = {
        let imageView                                       = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    fileprivate lazy var nameLabel: UILabel = {
        let label                                       = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font                                      = PromotionFont.resturantName
        label.textColor                                 = PromotionColor.title
        
        return label
    }()
    
    fileprivate lazy var distanceLabel: UILabel = {
        let label                                       = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font                                      = PromotionFont.distance
        label.textColor                                 = PromotionColor.distance
        
        return label
    }()
    
    fileprivate lazy var promotionContainerView: PromotionContainerView = {
        let promotionView                                       = PromotionContainerView(frame: .zero)
        promotionView.translatesAutoresizingMaskIntoConstraints = false
        
        return promotionView
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
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
            Size(100),
            Bottom(),
            Trailing()
        ]
    }
}
