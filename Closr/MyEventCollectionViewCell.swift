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
        
        static let avatarImageSize: CGSize                 = CGSize(width: 55, height: 55)
        static let avatarTopPadding: CGFloat               = 2.5
        
        static let eventTitlePadding: CGFloat              = 6
        
        static let participationImageSize: CGSize          = CGSize(width: 47.5, height: 10)
        
        static let timeImageSize: CGSize                   = CGSize(width: 11.81, height: 14.16)
        static let timeImageBottomPadding: CGFloat         = 23.4
        
        static let dateLabelLeadingPadding: CGFloat        = 6
        static let dataLabelBottomPadding: CGFloat         = 24.5
        
    }
    
    // TODO: - replace
    
    fileprivate lazy var avatarImageView: UIImageView = {
        let view                = UIImageView()
        view.layer.borderColor  = AppColor.brand.cgColor
        view.layer.borderWidth  = 1
        view.clipsToBounds      = true
        
        return view
    }()
    
    fileprivate lazy var participantsContainer: UIView = {
        
        let view                = UIView()
        view.backgroundColor    = UIColor.brown
        
        return view
    }()
    
    fileprivate lazy var eventTitleLabel: UILabel = UILabel.makeLabel(font: AppFont.smallText, textColor: AppColor.blackText)
    
    fileprivate lazy var dateLabel: UILabel = UILabel.makeLabel(font: AppFont.extraSmallText, textColor: AppColor.blackText)
    
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
        
            Size(Constants.avatarImageSize),
            Top(Constants.avatarTopPadding).to(contentView),
            Leading(0).to(contentView)
        
        ]
        
        eventTitleLabel <- [
            
            Top(Constants.eventTitlePadding).to(avatarImageView),
            Leading(0).to(contentView)

        ]
        
        participantsContainer <- [
            
            Size(Constants.participationImageSize),
            Top(Constants.eventTitlePadding).to(eventTitleLabel),
            Leading(0).to(contentView)
        
        ]
        
        timeImageView <- [
        
            Size(Constants.timeImageSize),
            Leading(0).to(contentView),
            Bottom(Constants.timeImageBottomPadding).to(contentView)
        
        ]
        
        dateLabel <- [
        
            Leading(Constants.dateLabelLeadingPadding).to(timeImageView),
            Bottom(Constants.dataLabelBottomPadding).to(contentView)
        
        ]
        
        
       
    }

    
    
}
