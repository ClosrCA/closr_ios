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
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.numberOfLines                             = 0
        nameLabel.textAlignment                             = .center
        nameLabel.font                                      = RestaurantFont.resturantName
        
        return nameLabel
    }()
    
    // TODO: Review view
    
    fileprivate lazy var openHoursDescriptionLabel: UILabel = {
        let label                                       = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text                                      = "Open hours:"
        label.textColor                                 = RestaurantColor.primary
        
        return label
    }()
    
    fileprivate lazy var phoneDescriptionLabel: UILabel = {
        let label                                       = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text                                      = "Phone:"
        label.textColor                                 = RestaurantColor.primary
        
        return label
    }()
    
    fileprivate lazy var addressDescriptionLabel: UILabel = {
        let label                                       = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text                                      = "Address:"
        label.textColor                                 = RestaurantColor.primary
        
        return label
    }()
    
    fileprivate lazy var openHoursLabel: UILabel = {
        let label                                       = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    fileprivate lazy var phoneLabel: UILabel = {
        let label                                       = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    fileprivate lazy var addressLabel: UILabel = {
        let label                                       = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
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
            Top(10)
        ]
        
        openHoursDescriptionLabel <- [
            Top().to(nameLabel, .bottom),
            Leading(40)
        ]
        
        phoneDescriptionLabel <- [
            Top().to(openHoursDescriptionLabel, .bottom),
            Trailing().to(openHoursDescriptionLabel, .trailing)
        ]
        
        addressDescriptionLabel <- [
            Top().to(phoneDescriptionLabel, .bottom),
            Trailing().to(phoneDescriptionLabel, .trailing),
            Bottom(10)
        ]
        
        openHoursLabel <- [
            Leading().to(openHoursDescriptionLabel, .trailing),
            CenterY().to(openHoursDescriptionLabel, .centerY)
        ]
        
        phoneLabel <- [
            Leading().to(phoneDescriptionLabel, .trailing),
            CenterY().to(phoneDescriptionLabel, .centerY)
        ]
        
        addressLabel <- [
            Leading().to(addressDescriptionLabel, .trailing),
            CenterY().to(addressDescriptionLabel, .centerY),
        ]
    }
}
