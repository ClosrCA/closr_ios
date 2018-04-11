//
//  MyEventCollectionViewCell.swift
//  Closr
//
//  Created by Yale的Mac on 2017/7/5.
//  Copyright © 2017年 closr. All rights reserved.
//

import UIKit
import EasyPeasy
import SwaggerClient

class MyEventCollectionViewCell: UICollectionViewCell, Reusable {
    
    static let preferredSize: CGSize = CGSize(width: 125, height: 130)
    
    fileprivate struct Constants {
        static let avatarLeftPadding: CGFloat       = 18
        static let eventTitlePadding: CGFloat       = 6
        static let timeImageBottomPadding: CGFloat  = 10
        static let dateLabelLeadingPadding: CGFloat = 6
    }
    
    fileprivate lazy var avatarImageView: UIImageView = {
        let view                = UIImageView()
        view.layer.borderColor  = AppColor.brand.cgColor
        view.layer.borderWidth  = 1
        view.layer.cornerRadius = AppSizeMetric.avatarSize.height / 2
        view.clipsToBounds      = true
        
        return view
    }()
    
    fileprivate lazy var attendantsContainerView: UIView = UIView()
    
    fileprivate lazy var titleLabel: UILabel = UILabel.makeLabel(font: AppFont.smallText, textColor: AppColor.text_dark)
    
    fileprivate lazy var dateLabel: UILabel = UILabel.makeLabel(font: AppFont.smallText, textColor: AppColor.text_dark)
    
    fileprivate lazy var timeImageView: UIImageView = {
        let imageView           = UIImageView(image: UIImage(named: "icon_time"))
        imageView.contentMode   = .scaleAspectFit
        
        return imageView
    }()
    
    func update(event: Event) {
        titleLabel.text = event.title
        avatarImageView.loadImage(URLString: event.author?.avatar)
        
        generateAttendantView(with: (event.attendees?.count ?? 0) + 1, capablility: Int(event.capacity ?? 0))
    }
    
    // TODO: - testing purpose
    func updateMockEvent(with attending: Int, capability: Int) {
        titleLabel.text    = "Dinner at Zen Cafe"
        dateLabel.text     = "05.05.1995 at 5:00pm"
        
        generateAttendantView(with: attending, capablility: capability)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(avatarImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(attendantsContainerView)
        contentView.addSubview(timeImageView)

        createConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    fileprivate func generateAttendantView(with attending: Int, capablility: Int) {
        for index in 0..<attending {
            
            let orangeAvatar = attendantImageView()
            
            layout(attendant: orangeAvatar, at: index)
        }
        
        let availablity = capablility - attending
        
        for index in 0..<availablity {
            
            let blackAvatar = availablityImageView()
            
            layout(attendant: blackAvatar, at: attending + index)
        }
    }
    
    fileprivate func attendantImageView() -> UIImageView {
        let imageView           = UIImageView(image: UIImage(named: "icon_user_orange"))
        imageView.contentMode   = .scaleAspectFit
        
        return imageView
    }
    
    fileprivate func availablityImageView() -> UIImageView {
        let imageView           = UIImageView(image: UIImage(named: "icon_user"))
        imageView.contentMode   = .scaleAspectFit
        
        return imageView
    }
    
    fileprivate func layout(attendant: UIImageView, at index: Int) {
        attendantsContainerView.addSubview(attendant)
        
        let leadingPadding = CGFloat(index) * (AppSizeMetric.defaultPadding + AppSizeMetric.iconSize.width)
        
        attendant.easy.layout(
            Size(AppSizeMetric.iconSize),
            CenterY(),
            Leading(leadingPadding)
        )
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        avatarImageView.cancelLoading()
        titleLabel.text = ""
        
        attendantsContainerView.subviews.forEach { $0.removeFromSuperview() }
    }
    
    fileprivate func createConstraints() {
        
        avatarImageView.easy.layout(
            Size(AppSizeMetric.avatarSize),
            Top(AppSizeMetric.defaultPadding),
            Leading(Constants.avatarLeftPadding)
        )
        
        titleLabel.easy.layout(
            Top(Constants.eventTitlePadding).to(avatarImageView),
            Leading().to(avatarImageView, .leading)
        )
        
        attendantsContainerView.easy.layout(
            Height(AppSizeMetric.iconSize.height),
            Top(Constants.eventTitlePadding).to(titleLabel),
            Leading().to(titleLabel, .leading),
            Trailing()
        )
        
        timeImageView.easy.layout(
            Size(AppSizeMetric.iconSize),
            Leading().to(titleLabel, .leading),
            Bottom(Constants.timeImageBottomPadding)
        )
        
        dateLabel.easy.layout(
            Leading(Constants.dateLabelLeadingPadding).to(timeImageView),
            Bottom().to(timeImageView, .bottom),
            Trailing()
        )
    }
}
