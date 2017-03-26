//
//  EventCollectionViewCell.swift
//  Closr
//
//  Created by ZHITAO TIAN on 2017-03-25.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit
import EasyPeasy

class EventCollectionViewCell: UICollectionViewCell, Reusable {
    
    static let preferredSize: CGSize = CGSize(width: 150, height: 145)
    
    fileprivate struct Constants {
        static let thumbnailSize: CGFloat = 74
        static let thumbnailTopPadding: CGFloat = 12
        
        static let labelVerticalPadding: CGFloat = 8
    }
    // TODO: - replace 
    
    fileprivate lazy var thumbnail: UIView = {
        let view                = UIView()
        view.backgroundColor    = AppColor.brand
        view.layer.cornerRadius = Constants.thumbnailSize / 2
        view.clipsToBounds      = true
        
        return view
    }()
    
    fileprivate lazy var titleLabel: UILabel = UILabel.makeLable(font: AppFont.text, textColor: AppColor.title)
    fileprivate lazy var dateLabel: UILabel = UILabel.makeLable(font: AppFont.smallText, textColor: AppColor.brand)
    
    func update(title: String?, date: Date?, avatars: [String]?, isCurrent: Bool = true) {
        
        dateLabel.textColor = isCurrent ? AppColor.brand : AppColor.greyText
        
        titleLabel.text = title
    
        if let date = date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = String.eventListDateFormat
            dateLabel.text = dateFormatter.string(from: date)
        }
        
        // TODO: - load avatars
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(thumbnail)
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
        
        createConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func createConstraints() {
        
        thumbnail <- [
            CenterX(),
            Top(Constants.thumbnailTopPadding),
            Size(Constants.thumbnailSize),
        ]
        
        titleLabel <- [
            CenterX(),
            Top(Constants.labelVerticalPadding).to(thumbnail),
            Leading(>=0),
            Trailing(<=0)
        ]
        
        dateLabel <- [
            CenterX(),
            Top(Constants.labelVerticalPadding).to(titleLabel)
        ]
    }
}
