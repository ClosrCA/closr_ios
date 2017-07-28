//
//  EventInfoTableViewCell.swift
//  Closr
//
//  Created by ZHITAO TIAN on 2017-07-26.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit
import EasyPeasy

class EventInfoTableViewCell: UITableViewCell, Reusable {

    fileprivate lazy var locationIcon: UIImageView = {
        let imageView   = UIImageView()
        imageView.image = UIImage(named: "distance_icon")
        
        return imageView
    }()
    
    fileprivate lazy var timeIcon: UIImageView = {
        let imageView   = UIImageView()
        imageView.image = UIImage(named: "time_icon")
        
        return imageView
    }()
    
    fileprivate lazy var addressLabel: UILabel     = UILabel.makeLabel(font: AppFont.text, textColor: AppColor.text_gray)
    fileprivate lazy var timeLabel: UILabel        = UILabel.makeLabel(font: AppFont.text, textColor: AppColor.text_gray)
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(locationIcon)
        contentView.addSubview(timeIcon)
        contentView.addSubview(addressLabel)
        contentView.addSubview(timeLabel)
        
        createConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(address: String?, readableTime: String?) {
        addressLabel.text   = address
        timeLabel.text      = readableTime
    }
    
    fileprivate func createConstraints() {
        locationIcon <- [
            Size(AppSizeMetric.iconSize),
            Top(AppSizeMetric.breathPadding),
            Leading(AppSizeMetric.breathPadding)
        ]
        
        timeIcon <- [
            Size(AppSizeMetric.iconSize),
            Top(AppSizeMetric.breathPadding).to(locationIcon),
            Leading().to(locationIcon, .leading),
            Bottom(AppSizeMetric.breathPadding)
        ]
        
        addressLabel <- [
            Leading(AppSizeMetric.defaultPadding).to(locationIcon),
            Top().to(locationIcon, .top)
        ]
        
        timeLabel <- [
            Leading(AppSizeMetric.defaultPadding).to(timeIcon),
            Bottom().to(timeIcon, .bottom)
        ]
    }
}
