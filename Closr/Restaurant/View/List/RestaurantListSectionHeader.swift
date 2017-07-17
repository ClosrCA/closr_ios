//
//  RestaurantListSectionHeader.swift
//  Closr
//
//  Created by ZHITAO TIAN on 2017-05-27.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit
import EasyPeasy

class RestaurantListSectionHeader: UITableViewHeaderFooterView, Reusable {
    
    fileprivate lazy var titleLabel: UILabel = UILabel.makeLabel(font: AppFont.smallText, textColor: AppColor.greyText)
    
    fileprivate lazy var accessoryLabel: UILabel = UILabel.makeLabel(font: AppFont.extraSmallText, textColor: AppColor.greyText)
    
    fileprivate lazy var accessoryImageView: UIImageView = UIImageView()
    
    func update(title: String? = " ", accessoryTitle: String? = nil, accessoryImage: UIImage? = nil) {
        titleLabel.text             = title
        accessoryLabel.text         = accessoryTitle
        accessoryImageView.image    = accessoryImage
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor.white
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(accessoryLabel)
        contentView.addSubview(accessoryImageView)
        
        createConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createConstraints() {
        titleLabel <- [
            Top(10),
            Leading(10),
            Bottom()
        ]
        
        accessoryImageView <- [
            Size(15),
            CenterY(),
            Trailing(10)
        ]
        
        accessoryLabel <- [
            Trailing().to(accessoryImageView, .leading),
            CenterY()
        ]
    }
}
