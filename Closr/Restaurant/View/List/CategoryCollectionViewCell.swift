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
    
    struct Constants {
        static let lineSpace: CGFloat   = 13
        static let imageSize: CGSize    = CGSize(width: 123, height: 71)
        static let cellSize: CGSize     = CGSize(width: 143, height: 91)
    }
    
    static var preferredCellSize: CGSize {
        return Constants.cellSize
    }
    
    static var preferredLineSpace: CGFloat {
        return Constants.lineSpace
    }
    
    fileprivate lazy var shadowBackgroundImageView: UIImageView = {
        let background = UIImage(named: "icon_category_background")
        
        let imageView           = UIImageView(image: background)
        imageView.contentMode   = .scaleAspectFill
        
        return imageView
    }()
    
    fileprivate lazy var categoryImageView: UIImageView = {
        let imageView           = UIImageView()
        imageView.contentMode   = .scaleAspectFill
        
        return imageView
    }()
    
    fileprivate lazy var categoryLabel: UILabel = UILabel.makeLabel(font: AppFont.smallText, textColor: AppColor.text_dark)
    
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
            Size(Constants.imageSize),
            Top(),
            Trailing()
        ]
        
        shadowBackgroundImageView <- [
            Size(Constants.imageSize),
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
