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
        static let horizontalPadding: CGFloat   = 8
        static let verticalPadding: CGFloat     = 13
        
        static let avatarSize: CGSize               = CGSize(width: 55, height: 55)
        static let avatarVerticalPadding: CGFloat   = 9
        static let avatarLeftPadding: CGFloat       = 13
        
        static let titleTopPadding: CGFloat     = 12
        static let titleLeftPadding: CGFloat    = 18
        static let titleBottomPadding: CGFloat  = 6
        
        static let restaurantNameTopPadding: CGFloat = 6
        
        static let iconSize: CGSize                     = CGSize(width: 15, height: 15)
        static let iconRightPaddingToContainer: CGFloat = 64
        static let iconVerticalPadding: CGFloat         = 14
        static let iconVerticalSpace: CGFloat           = 16
        
        static let timeLeftPadding: CGFloat = 8
    }
    
    fileprivate lazy var containerView: UIView = {
    
        let view = UIView()
        
        view.backgroundColor    = UIColor.white
        view.layer.borderColor  = AppColor.secondary.cgColor
        view.layer.cornerRadius = 9.0
        view.layer.borderWidth  = 1
        
        return view;
    
    }()
    
    fileprivate lazy var titleLabel: UILabel = UILabel.makeLabel(font: AppFont.text, textColor: AppColor.title, text: "Event Title")
    
    fileprivate lazy var restaurantLabel: UILabel = UILabel.makeLabel(font: AppFont.smallText, textColor: AppColor.title, text: "Restaurant Name")

    fileprivate lazy var distanceLabel: UILabel = UILabel.makeLabel(font: AppFont.smallText, textColor: AppColor.title, text: "10.5km")

    fileprivate lazy var timeLabel: UILabel = UILabel.makeLabel(font: AppFont.smallText, textColor: AppColor.title, text: "25 min")

    fileprivate lazy var avatarImageView: UIImageView = {
        
        let imageView                   = UIImageView(image: UIImage(named: "user"))
        imageView.contentMode           = .center
        imageView.layer.cornerRadius    = Constants.avatarSize.height / 2
        imageView.clipsToBounds         = true
        
        return imageView
    }()

    // TODO: generator
    fileprivate lazy var participantsContainer: UIView = {
        
        let view                = UIView()
        view.backgroundColor    = UIColor.brown
        
        return view
    }()
    
    fileprivate lazy var timeImageView: UIImageView = UIImageView(image: UIImage(named: "time_icon"))
    
    fileprivate lazy var distanceImageView: UIImageView = UIImageView(image: UIImage(named: "distance_icon"))
    
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
    }
    
    fileprivate func setupSubviews() {
        contentView.addSubview(containerView);
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(restaurantLabel)
        containerView.addSubview(distanceLabel)
        containerView.addSubview(timeLabel)
        containerView.addSubview(avatarImageView)
        containerView.addSubview(participantsContainer)
        containerView.addSubview(timeImageView)
        containerView.addSubview(distanceImageView)
    }
    
    fileprivate func createConstraints() {
        
        containerView <- [
            Leading(Constants.horizontalPadding),
            Trailing(Constants.horizontalPadding),
            Top(Constants.verticalPadding),
            Bottom(Constants.verticalPadding)
        ]
        
        avatarImageView <- [
            Size(Constants.avatarSize),
            Top(Constants.avatarVerticalPadding),
            Bottom(Constants.avatarVerticalPadding),
            Leading(Constants.avatarLeftPadding)
        ]
        
        titleLabel <- [
            Top(Constants.titleTopPadding),
            Leading(Constants.titleLeftPadding).to(avatarImageView),
            Bottom(Constants.titleBottomPadding).to(participantsContainer),
            Trailing(<=0).to(timeImageView)
        ]
        
        participantsContainer <- [
            Leading().to(titleLabel, .leading),
            Size(CGSize(width: 50, height: 10))
        ]
        
        restaurantLabel <- [
            Top(Constants.restaurantNameTopPadding).to(participantsContainer),
            Leading().to(titleLabel, .leading)
        ]
        
        timeImageView <- [
            Size(Constants.iconSize),
            Top(Constants.iconVerticalPadding),
            Trailing(Constants.iconRightPaddingToContainer)
        ]
        
        distanceImageView <- [
            Size(Constants.iconSize),
            Bottom(Constants.iconVerticalPadding),
            Trailing(Constants.iconRightPaddingToContainer)
        ]
        
        timeLabel <- [
            Leading(Constants.timeLeftPadding).to(timeImageView),
            CenterY().to(timeImageView)
        ]
        
        distanceLabel <- [
            Leading().to(timeLabel, .leading),
            CenterY().to(distanceImageView)
        ]
    }
}

