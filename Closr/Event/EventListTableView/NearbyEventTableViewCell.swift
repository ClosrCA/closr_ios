//
//  NearbyEventTableViewCell.swift
//  Closr
//
//  Created by Yale的Mac on 2017/3/31.
//  Copyright © 2017年 closr. All rights reserved.
//

import UIKit
import EasyPeasy

class NearbyEventTableViewCell: UITableViewCell,Reusable {
    
    
    
    override init(style: UITableViewCellStyle,reuseIdentifier reuseIdentifire: String?){
        
        super.init(style: style, reuseIdentifier: reuseIdentifire)
        
        setUpViews()
        createConstraints()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    fileprivate lazy var nearbyImageView: UIImageView = {
        let imageView   = UIImageView()
        imageView.backgroundColor=UIColor.blue
        
        return  imageView
        
    }()
    
    
    
    
    fileprivate lazy var nameLabel: UILabel = {
        let label       = UILabel()
        label.text      = "Restaurant Name"
        label.font      = EventListFont.nearbyRestaurantName
        label.textColor = EventListColor.nearbyRestaurantName
        
        return label
    }()
    
    
    fileprivate lazy var addressLabel: UILabel = {
        let label       = UILabel()
        label.text      = "Restaurant Address"
        label.font      = EventListFont.nearbyRestuarantAddress
        label.textColor = EventListColor.nearbyRestuarantAddress
        
        return label
    }()
    
    
    fileprivate lazy var dateLabel: UILabel = {
        let label       = UILabel()
        label.text      = "2017.02.14 5pm"
        label.font      = EventListFont.nearbyDate
        label.textColor = EventListColor.nearbyDate
        return label
    }()
    
    
    fileprivate lazy var distanceLabel: UILabel = {
        let label       = UILabel()
        label.text      = "2.5km"
        label.font      = EventListFont.nearbyRestaruantDistance
        label.textColor = EventListColor.nearbyRestuarantDistance
        
        return label
    }()
    
    
    
    
    fileprivate func setUpViews(){
        
        contentView.addSubview(nearbyImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(addressLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(distanceLabel)
        
        
    }
    
    fileprivate func createConstraints(){
        
        nearbyImageView <- [
            Height(EventListConstant.nearbyImageViewHeight),
            Width(EventListConstant.nearbyImageViewWidth),
            Top(EventListConstant.nearbyImageViewTopPadding),
            Leading(EventListConstant.nearbyImageViewLeadingPadding)
            
        ]
        
        nameLabel <-  [
            Top(EventListConstant.nearbyReataurantNameTopPadding),
            Leading(EventListConstant.nearbyLabelImageViewPadding).to(nearbyImageView,.trailing)
            
        ]
        
        addressLabel <- [
            Top(EventListConstant.nearbyRestaurantAddressTopPadding).to(nameLabel,.bottom),
            Leading(EventListConstant.nearbyLabelImageViewPadding).to(nearbyImageView,.trailing)
            
        ]
        
        dateLabel <-  [
            Top(EventListConstant.nearbyDateTopPadding).to(addressLabel,.bottom),
            Leading(EventListConstant.nearbyLabelImageViewPadding).to(nearbyImageView,.trailing)
            
        ]
        
        distanceLabel <- [
            Top(EventListConstant.nearbyDateTopPadding).to(dateLabel,.bottom),
            Bottom(EventListConstant.nearbyDistanceBottomPadding),
            Leading(EventListConstant.nearbyLabelImageViewPadding).to(nearbyImageView,.trailing)
            
        ]
        
        
    }
    
    
    
    
}
