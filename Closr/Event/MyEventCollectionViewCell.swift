//
//  MyEventCollectionViewCell.swift
//  Closr
//
//  Created by Yale的Mac on 2017/7/5.
//  Copyright © 2017年 closr. All rights reserved.
//

import UIKit
import EasyPeasy

class MyEventCollectionViewCell: UICollectionViewCell, Reusable {
    
    static let preferredSize: CGSize = CGSize(width: 125, height: 145)
    
    fileprivate struct Constants {
        static let avatarLeftPadding: CGFloat       = 18
        
        static let eventTitlePadding: CGFloat              = 6
        
        static let participationImageSize: CGSize          = CGSize(width: 47.5, height: 10)
        
        static let timeImageBottomPadding: CGFloat         = 10
        
        static let dateLabelLeadingPadding: CGFloat        = 6
    }
    
    fileprivate lazy var avatarImageView: UIImageView = {
        let view                = UIImageView()
        view.layer.borderColor  = AppColor.brand.cgColor
        view.layer.borderWidth  = 1
        view.layer.cornerRadius = AppSizeMetric.avatarSize.height / 2
        view.clipsToBounds      = true
        
        return view
    }()
    
    // TODO: - replace
    fileprivate lazy var participantsContainer: UIView = {
        
        let view                = UIView()
        view.backgroundColor    = UIColor.brown
        
        return view
    }()
    
    fileprivate lazy var eventTitleLabel: UILabel = UILabel.makeLabel(font: AppFont.smallText, textColor: AppColor.text_gray)
    
    fileprivate lazy var dateLabel: UILabel = UILabel.makeLabel(font: AppFont.smallText, textColor: AppColor.text_gray)
    
     fileprivate lazy var timeImageView: UIImageView = UIImageView(image: UIImage(named: "time_icon"))
    
    
    fileprivate func testData() {
    
        eventTitleLabel.text = "Event Title"
        dateLabel.text = "05.05.1995 at 5:00pm"
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(avatarImageView)
        contentView.addSubview(eventTitleLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(participantsContainer)
        contentView.addSubview(timeImageView)
        
        testData()

        createConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    
    fileprivate func createConstraints() {
        
        avatarImageView <- [
            Size(AppSizeMetric.avatarSize),
            Top(AppSizeMetric.defaultPadding),
            Leading(Constants.avatarLeftPadding)
        ]
        
        eventTitleLabel <- [
            Top(Constants.eventTitlePadding).to(avatarImageView),
            Leading().to(avatarImageView, .leading)

        ]
        
        participantsContainer <- [
            Size(Constants.participationImageSize),
            Top(Constants.eventTitlePadding).to(eventTitleLabel),
            Leading().to(eventTitleLabel, .leading)
        ]
        
        timeImageView <- [
            Size(AppSizeMetric.iconSize),
            Leading().to(eventTitleLabel, .leading),
            Bottom(Constants.timeImageBottomPadding)
        ]
        
        dateLabel <- [
            Leading(Constants.dateLabelLeadingPadding).to(timeImageView),
            Bottom().to(timeImageView, .bottom),
            Trailing()
        ]
    }
}
