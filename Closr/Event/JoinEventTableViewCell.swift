//
//  JoinEventTableViewCell.swift
//  Closr
//
//  Created by Yale的Mac on 2017/6/28.
//  Copyright © 2017年 closr. All rights reserved.
//

import UIKit
import EasyPeasy


class JoinEventTableViewCell: UITableViewCell, Reusable{
    
    struct Constants {
        static let verticalPadding: CGFloat     = 13
        
        static let avatarVerticalPadding: CGFloat   = 9
        static let avatarLeftPadding: CGFloat       = 13
        
        static let titleTopPadding: CGFloat     = 12
        static let titleLeftPadding: CGFloat    = 18
        static let titleBottomPadding: CGFloat  = 6
        
        static let restaurantNameTopPadding: CGFloat = 6
        
        static let iconRightPaddingToContainer: CGFloat = 64
        static let iconVerticalPadding: CGFloat         = 14
        static let iconVerticalSpace: CGFloat           = 16
        
        static let attendantContainerSize: CGSize = CGSize(width: 50, height: 12)
    }
    
    fileprivate lazy var containerView: UIView = {
    
        let view = UIView()
        
        view.backgroundColor    = UIColor.white
        view.layer.borderColor  = AppColor.secondary.cgColor
        view.layer.cornerRadius = 9.0
        view.layer.borderWidth  = 1
        
        return view;
    
    }()
    
    fileprivate lazy var titleLabel: UILabel = UILabel.makeLabel(font: AppFont.text, textColor: AppColor.text_dark, text: "Event Title")
    
    fileprivate lazy var restaurantLabel: UILabel = UILabel.makeLabel(font: AppFont.smallText, textColor: AppColor.text_dark, text: "Restaurant Name")

    fileprivate lazy var distanceLabel: UILabel = UILabel.makeLabel(font: AppFont.smallText, textColor: AppColor.text_dark, text: "10.5km")

    fileprivate lazy var timeLabel: UILabel = UILabel.makeLabel(font: AppFont.smallText, textColor: AppColor.text_dark, text: "25 min")

    fileprivate lazy var avatarImageView: UIImageView = {
        
        let imageView                   = UIImageView(image: UIImage(named: "user"))
        imageView.contentMode           = .center
        imageView.layer.cornerRadius    = AppSizeMetric.avatarSize.height / 2
        imageView.clipsToBounds         = true
        
        return imageView
    }()

    fileprivate lazy var attendantsContainer: UIView = UIView()
    
    fileprivate lazy var timeImageView: UIImageView = {
        let imageView           = UIImageView(image: UIImage(named: "icon_time"))
        imageView.contentMode   = .scaleAspectFit
        
        return imageView
    }()
    
    fileprivate lazy var distanceImageView: UIImageView = {
        let imageView           = UIImageView(image: UIImage(named: "icon_location"))
        imageView.contentMode   = .scaleAspectFit
        
        return imageView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        setupSubviews()
        
        createConstraints();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with event: Event) {
        titleLabel.text = event.title
        avatarImageView.loadImage(URLString: event.author?.avatar)
        restaurantLabel.text = event.restaurant.name
        
        generateAttendantView(with: event.participants.count + 1, capablility: event.numberOfPeople)
    }
    
    // TODO: testing purpose
    func updateMockEvent(with attending: Int, capability: Int) {
        titleLabel.text = "Dinner at Zen Cafe"
        avatarImageView.image = UIImage(named: "icon_user")
        restaurantLabel.text = "Zen Cafe"
        generateAttendantView(with: attending, capablility: capability)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        avatarImageView.cancelLoading()
        
        titleLabel.text         = ""
        avatarImageView.image   = nil
        restaurantLabel.text    = ""
        
        attendantsContainer.subviews.forEach { $0.removeFromSuperview() }
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
        attendantsContainer.addSubview(attendant)
        
        let leadingPadding = CGFloat(index) * (AppSizeMetric.defaultPadding + AppSizeMetric.iconSize.width)
        
        attendant <- [
            Size(AppSizeMetric.iconSize),
            CenterY(),
            Leading(leadingPadding)
        ]
    }
    
    fileprivate func setupSubviews() {
        contentView.addSubview(containerView);
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(restaurantLabel)
        containerView.addSubview(distanceLabel)
        containerView.addSubview(timeLabel)
        containerView.addSubview(avatarImageView)
        containerView.addSubview(attendantsContainer)
        containerView.addSubview(timeImageView)
        containerView.addSubview(distanceImageView)
    }
    
    fileprivate func createConstraints() {
        
        containerView <- [
            Leading(AppSizeMetric.defaultPadding),
            Trailing(AppSizeMetric.defaultPadding),
            Top(Constants.verticalPadding),
            Bottom(Constants.verticalPadding)
        ]
        
        avatarImageView <- [
            Size(AppSizeMetric.avatarSize),
            Top(Constants.avatarVerticalPadding),
            Bottom(Constants.avatarVerticalPadding),
            Leading(Constants.avatarLeftPadding)
        ]
        
        titleLabel <- [
            Top(Constants.titleTopPadding),
            Leading(Constants.titleLeftPadding).to(avatarImageView),
            Bottom(Constants.titleBottomPadding).to(attendantsContainer),
            Trailing(<=0).to(timeImageView)
        ]
        
        attendantsContainer <- [
            Leading().to(titleLabel, .leading),
            Size(Constants.attendantContainerSize)
        ]
        
        restaurantLabel <- [
            Top(Constants.restaurantNameTopPadding).to(attendantsContainer),
            Leading().to(titleLabel, .leading)
        ]
        
        timeImageView <- [
            Size(AppSizeMetric.iconSize),
            Top(Constants.iconVerticalPadding),
            Trailing(Constants.iconRightPaddingToContainer)
        ]
        
        distanceImageView <- [
            Size(AppSizeMetric.iconSize),
            Bottom(Constants.iconVerticalPadding),
            Trailing(Constants.iconRightPaddingToContainer)
        ]
        
        timeLabel <- [
            Leading(AppSizeMetric.defaultPadding).to(timeImageView),
            CenterY().to(timeImageView)
        ]
        
        distanceLabel <- [
            Leading().to(timeLabel, .leading),
            CenterY().to(distanceImageView)
        ]
    }
}

