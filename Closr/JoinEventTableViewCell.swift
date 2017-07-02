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

    var isCurrent: Bool = true {
        didSet {
           // collectionView.backgroundColor = isCurrent ? AppColor.brandBackground : UIColor.white
        }
    }
    
    fileprivate lazy var cellView: UIView = {
    
        let view = UIView();
        
        view.backgroundColor = UIColor.white
        view.layer.borderColor = AppColor.brand.cgColor
        view.layer.borderWidth = 1
        
        return view;
    
    }()
    
    fileprivate lazy var eventTitleLabel: UILabel = UILabel.makeLabel(font: AppFont.joinEventlargeTitle, textColor: AppColor.joinEventText, text: "Event Title")
    
    
    fileprivate lazy var eventRestaurantLabel: UILabel = UILabel.makeLabel(font: AppFont.joinEventSmallText, textColor: AppColor.joinEventText, text: "Restaurant Name")

    fileprivate lazy var eventDistanceLabel: UILabel = UILabel.makeLabel(font: AppFont.joinEventSmallText, textColor: AppColor.joinEventText, text: "10.5km")

    fileprivate lazy var eventTimeRemainingLabel: UILabel = UILabel.makeLabel(font: AppFont.joinEventSmallText, textColor: AppColor.joinEventText, text: "25 min")

    fileprivate lazy var portraitthumbnailContainer: UIView = {
        
        let view                = UIView();
        
        view.layer.borderColor  = AppColor.brand.cgColor
        //view.layer.borderWidth  = 2
        view.clipsToBounds      = true
        view.backgroundColor = UIColor.blue
        
        return view
    }()

    
    fileprivate lazy var peoplethumbnailContainer: UIView = {
        
        let view                = UIView()
       
        view.layer.borderColor  = AppColor.brand.cgColor
       // view.layer.borderWidth  = 2
        view.clipsToBounds      = true
        view.backgroundColor = UIColor.brown
        
        return view
    }()
    
    fileprivate lazy var timethumbnailContainer: UIView = {
        
        let view                = UIView()
    
        view.layer.borderColor  = AppColor.brand.cgColor
      //  view.layer.borderWidth  = 2
        view.clipsToBounds      = true
        view.backgroundColor = UIColor.black
        
        return view
    }()
    

    fileprivate lazy var distancethumbnailContainer: UIView = {
        
        let view                = UIView()
        
        view.layer.borderColor  = AppColor.brand.cgColor
      //  view.layer.borderWidth  = 2
        view.clipsToBounds      = true
        view.backgroundColor = UIColor.green
        
        return view
    }()
    

    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        contentView.addSubview(cellView);
        
        
        cellView.addSubview(eventTitleLabel);
        cellView.addSubview(eventRestaurantLabel);
        cellView.addSubview(eventDistanceLabel);
        cellView.addSubview(eventTimeRemainingLabel);
        
        cellView.addSubview(portraitthumbnailContainer);
        cellView.addSubview(peoplethumbnailContainer);
        cellView.addSubview(timethumbnailContainer);
        cellView.addSubview(distancethumbnailContainer);
        
        addConstraint2init();
       
    }
    
    func addConstraint2init() {
        
        cellView <- [
        
            Left(cellViewConstants.labelLeftPadding).to(contentView),
            Right(cellViewConstants.labelRightPadding).to(contentView),
            Top(cellViewConstants.labelTopPadding).to(contentView),
            Bottom(cellViewConstants.labelBottomPadding).to(contentView)
        
        ]
        
        portraitthumbnailContainer <- [
            
            CenterY(),
            Left(PortraitConstants.leftPadding).to(cellView),
            Top(PortraitConstants.topPadding).to(cellView),
            Height(PortraitConstants.thumbnailHeight),
            Width(PortraitConstants.thumbnailWidth)
            
        ]
        
        eventTitleLabel <- [
        
            Top(eventTitleLabelConstants.labelTopPadding).to(cellView),
            Left(eventTitleLabelConstants.labelLeftPadding).to(portraitthumbnailContainer)
            
        ]
        
        peoplethumbnailContainer <- [
        
            Top(PeopleConstants.topPadding).to(eventTitleLabel),
            Left(PeopleConstants.leftPadding).to(portraitthumbnailContainer),
            Height(PeopleConstants.thumbnailHeight),
            Width(PeopleConstants.thumbnailWidth)

        
        ]
        
        eventRestaurantLabel <- [
        
            Top(eventRestaurantLabelConstants.labelTopPadding).to(peoplethumbnailContainer),
            Left(eventRestaurantLabelConstants.labelLeftPadding).to(portraitthumbnailContainer),
            Bottom(eventDistanceLabelConstants.labelBottomPadding).to(cellView)
        
        ]
        
        timethumbnailContainer <- [
        
            Top(timeConstants.topPadding).to(cellView),
            Left(timeConstants.leftPadding).to(cellView),
            Height(timeConstants.thumbnailHeight),
            Width(timeConstants.thumbnailWidth)
        
        ]
        
        distancethumbnailContainer <- [
        
            Bottom(distanceConstants.bottomPadding).to(cellView),
            Left(distanceConstants.leftPadding).to(cellView),
            Height(distanceConstants.thumbnailHeight),
            Width(distanceConstants.thumbnailWidth)
        
        ]
        
        eventTimeRemainingLabel <- [
        
            Top(eventTimeRemainingLabelConstants.labelTopPadding).to(cellView),
            Left(eventTimeRemainingLabelConstants.labelLeftPadding).to(timethumbnailContainer)
        
        ]
        
        eventDistanceLabel <- [
        
            Bottom(eventDistanceLabelConstants.labelBottomPadding).to(cellView),
            Left(eventDistanceLabelConstants.labelLeftPadding).to(distancethumbnailContainer)
        
        ]
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

