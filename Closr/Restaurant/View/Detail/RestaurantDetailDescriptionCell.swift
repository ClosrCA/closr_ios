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
        let nameLabel                                       = UILabel()
        nameLabel.numberOfLines                             = 0
        nameLabel.textAlignment                             = .center
        nameLabel.textColor                                 = RestaurantColor.title
        nameLabel.font                                      = RestaurantFont.resturantName
        
        return nameLabel
    }()
    
    // TODO: Review view
    // TODO: Cuisin and price
    
    fileprivate lazy var openHoursDescriptionLabel: UILabel = {
        let label                                       = UILabel()
        label.text                                      = "Open hours:"
        label.font                                      = RestaurantFont.infoTitle
        label.textColor                                 = RestaurantColor.primary
        
        return label
    }()
    
    fileprivate lazy var phoneDescriptionLabel: UILabel = {
        let label                                       = UILabel()
        label.text                                      = "Phone:"
        label.font                                      = RestaurantFont.infoTitle
        label.textColor                                 = RestaurantColor.primary
        
        return label
    }()
    
    fileprivate lazy var addressDescriptionLabel: UILabel = {
        let label                                       = UILabel()
        label.text                                      = "Address:"
        label.font                                      = RestaurantFont.infoTitle
        label.textColor                                 = RestaurantColor.primary
        
        return label
    }()
    
    fileprivate lazy var openHoursLabel: UILabel = {
        let label                                       = UILabel()
        label.font                                      = RestaurantFont.infoTitle
        label.textColor                                 = RestaurantColor.subtitle
        
        return label
    }()
    
    fileprivate lazy var phoneLabel: UILabel = {
        let label                                       = UILabel()
        label.font                                      = RestaurantFont.infoTitle
        label.textColor                                 = RestaurantColor.subtitle
        
        return label
    }()
    
    fileprivate lazy var addressLabel: UILabel = {
        let label                                       = UILabel()
        label.font                                      = RestaurantFont.infoTitle
        label.textColor                                 = RestaurantColor.subtitle
        
        return label
    }()
    
    func update(restaurant: YelpPlace) {
        nameLabel.text      = restaurant.name
        addressLabel.text   = restaurant.address?.displayAddress?.first
        phoneLabel.text     = restaurant.phone
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(openHoursDescriptionLabel)
        contentView.addSubview(openHoursLabel)
        contentView.addSubview(phoneDescriptionLabel)
        contentView.addSubview(phoneLabel)
        contentView.addSubview(addressDescriptionLabel)
        contentView.addSubview(addressLabel)
        
        createConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func createConstraints() {
        
        nameLabel <- [
            Leading(),
            Trailing(),
            Top(RestaurantDetailConstant.restaurantNameTopPadding)
        ]
        
        openHoursDescriptionLabel <- [
            Top(RestaurantDetailConstant.infoSectionVerticalPadding).to(nameLabel, .bottom),
            Leading(RestaurantDetailConstant.infoSectionLeadingPadding)
        ]
        
        phoneDescriptionLabel <- [
            Top(RestaurantDetailConstant.infoInternalPadding).to(openHoursDescriptionLabel, .bottom),
            Trailing().to(openHoursDescriptionLabel, .trailing)
        ]
        
        addressDescriptionLabel <- [
            Top(RestaurantDetailConstant.infoInternalPadding).to(phoneDescriptionLabel, .bottom),
            Trailing().to(phoneDescriptionLabel, .trailing),
            Bottom(RestaurantDetailConstant.infoSectionVerticalPadding)
        ]
        
        openHoursLabel <- [
            Leading(8).to(openHoursDescriptionLabel, .trailing),
            Trailing(<=8),
            CenterY().to(openHoursDescriptionLabel, .centerY)
        ]
        
        phoneLabel <- [
            Leading(8).to(phoneDescriptionLabel, .trailing),
            Trailing(<=8),
            CenterY().to(phoneDescriptionLabel, .centerY)
        ]
        
        addressLabel <- [
            Leading(8).to(addressDescriptionLabel, .trailing),
            Trailing(<=8),
            CenterY().to(addressDescriptionLabel, .centerY),
        ]
    }
}
