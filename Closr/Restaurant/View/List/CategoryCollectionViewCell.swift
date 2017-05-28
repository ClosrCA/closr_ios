//
//  CategoryCollectionViewCell.swift
//  Closr
//
//  Created by ZHITAO TIAN on 2017-05-27.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit
import EasyPeasy

class CategoryCollectionViewCell: UICollectionViewCell, Reusable {
    
    fileprivate lazy var shadowBackgroundImageView: UIImageView = {
        let background = UIImage(named: "category_background")
        
        let imageView           = UIImageView(image: background)
        imageView.contentMode   = .scaleAspectFill
        
        return imageView
    }()
    
    fileprivate lazy var categoryImageView: UIImageView = {
        let imageView           = UIImageView()
        imageView.contentMode   = .scaleAspectFill
        
        return imageView
    }()
    
    fileprivate lazy var categoryLabel: UILabel = UILabel.makeLabel(font: AppFont.smallText, textColor: AppColor.title)
    
    func update(with item: CategoryItem) {
        categoryLabel.text      = item.title
        categoryImageView.image = item.image
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        shadowBackgroundImageView.addSubview(categoryLabel)
        contentView.addSubview(shadowBackgroundImageView)
        contentView.addSubview(categoryImageView)
        
        createConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        categoryImageView.image = nil
        categoryLabel.text      = nil
    }
    
    fileprivate func createConstraints() {
        categoryImageView <- [
            Size(RestaurantListConstant.Category.imageSize),
            Top(),
            Trailing()
        ]
        
        shadowBackgroundImageView <- [
            Size(RestaurantListConstant.Category.imageSize),
            Bottom(),
            Leading()
        ]
        
        categoryLabel <- [
            Bottom(5),
            Leading(),
            Trailing()
        ]
    }
}
