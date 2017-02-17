//
//  PromotionContainerView.swift
//  Closr
//
//  Created by Tao on 2017-02-16.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit
import EasyPeasy

class PromotionContainerView: UIView {
    
    func updateWith(promotion: Promotion) {
        
        if let discount = promotion.discount {
            discountLabel.text  = discount
            itemLabel.text      = "off"
        } else {
            dollarSignLabel.text    = promotion.currency
            priceLabel.text         = promotion.price
            quantityLabel.text      = promotion.quantity
            itemLabel.text          = promotion.item
        }
    }
    
    func prepareForReuse() {
        discountLabel.text      = nil
        dollarSignLabel.text    = nil
        priceLabel.text         = nil
        quantityLabel.text      = nil
        itemLabel.text          = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(backgroundImageView)
        addSubview(discountLabel)
        addSubview(dollarSignLabel)
        addSubview(priceLabel)
        addSubview(quantityLabel)
        addSubview(itemLabel)
        
        createConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate lazy var backgroundImageView: UIImageView = {
        let imageView                                       = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    fileprivate lazy var discountLabel: UILabel = {
        let label                                       = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font                                      = PromotionFont.discount
        label.textColor                                 = PromotionColor.primary
        
        return label
    }()
    
    fileprivate lazy var dollarSignLabel: UILabel = {
        let label                                       = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font                                      = PromotionFont.dollarSign
        label.textColor                                 = PromotionColor.primary
        
        return label
    }()
    
    fileprivate lazy var priceLabel: UILabel = {
        let label                                       = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font                                      = PromotionFont.price
        label.textColor                                 = PromotionColor.primary
        
        return label
    }()
    
    fileprivate lazy var quantityLabel: UILabel = {
        let label                                       = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font                                      = PromotionFont.quantity
        label.textColor                                 = PromotionColor.secondary
        
        return label
    }()
    
    fileprivate lazy var itemLabel: UILabel = {
        let label                                       = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font                                      = PromotionFont.item
        label.textColor                                 = PromotionColor.secondary
        
        return label
    }()
    
    fileprivate func createConstraints() {
        
        backgroundImageView <- Edges()
        
        discountLabel <- [
            CenterX(),
            Top(10)
        ]
        
        dollarSignLabel <- [
            Leading(20),
            Top(10)
        ]
        
        priceLabel <- [
            Leading().to(dollarSignLabel, .trailing),
            FirstBaseline().to(dollarSignLabel, .firstBaseline)
        ]
        
        quantityLabel <- [
            Leading().to(dollarSignLabel, .leading),
            Bottom(10)
        ]
        
        itemLabel <- [
            Leading().to(quantityLabel, .trailing),
            Bottom(10)
        ]
    }
}
