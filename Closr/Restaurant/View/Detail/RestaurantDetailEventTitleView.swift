//
//  RestaurantDetailEventTitleView.swift
//  Closr
//
//  Created by Tao on 2017-03-08.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit
import EasyPeasy

class RestaurantDetailEventTitleView: UIView {

    fileprivate lazy var topDivider: UIView = {
        let view                = UIView()
        view.backgroundColor    = AppColor.lightGreyText
        
        return view
    }()
    
    fileprivate lazy var titleLabel: UILabel = UILabel.makeLable(font: AppFont.title, textColor: AppColor.title, text: "Current Event")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(topDivider)
        addSubview(titleLabel)
        
        createConstraints()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func createConstraints() {
        topDivider <- [
            Leading(20),
            Trailing(20),
            Top(),
            Height(RestaurantDetailConstant.EventList.eventDividerHeight)
        ]
        
        titleLabel <- [
            Top(RestaurantDetailConstant.EventList.eventTitleVerticalPadding).to(topDivider, .bottom),
            Bottom(RestaurantDetailConstant.EventList.eventTitleVerticalPadding),
            CenterX()
        ]
    }

}
