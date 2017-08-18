//
//  TableViewSectionHeader.swift
//  Closr
//
//  Created by ZHITAO TIAN on 2017-05-27.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit
import EasyPeasy

class TableViewSectionHeader: UITableViewHeaderFooterView, Reusable {
    
    fileprivate lazy var titleLabel: UILabel        = UILabel.makeLabel(font: AppFont.text, textColor: AppColor.text_dark)
    fileprivate lazy var accessoryLabel: UILabel    = UILabel.makeLabel(font: AppFont.smallText, textColor: AppColor.text_gray)
    
    fileprivate lazy var accessoryImageView: UIImageView = UIImageView()
    
    func update(title: String, accessoryTitle: String? = nil, accessoryImage: UIImage? = nil) {
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
            Top(AppSizeMetric.defaultPadding),
            Leading(AppSizeMetric.defaultPadding),
            Bottom()
        ]
        
        accessoryImageView <- [
            Size(AppSizeMetric.iconSize),
            CenterY(),
            Trailing(AppSizeMetric.defaultPadding)
        ]
        
        accessoryLabel <- [
            Trailing().to(accessoryImageView, .leading),
            CenterY()
        ]
    }
}
