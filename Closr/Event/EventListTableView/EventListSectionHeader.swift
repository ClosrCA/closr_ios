//
//  EventListSectionHeader.swift
//  Closr
//
//  Created by Yale的Mac on 2017/3/31.
//  Copyright © 2017年 closr. All rights reserved.
//

import UIKit
import EasyPeasy

class EventListSectionHeader: UITableViewHeaderFooterView,Reusable{
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setUpViews()
        createConstraints()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    fileprivate var sectionNameLabel: UILabel = {
        let label       = UILabel()
        label.font      = EventListFont.sectionHeader
        label.textColor = EventListColor.sectionHeaderText
        label.text      = "HEADER"
        
        return label
    }()
    
    func update(title: String) {
        sectionNameLabel.text = title
        
    }
    
    func setUpViews(){
        
        contentView.addSubview(sectionNameLabel)
        contentView.backgroundColor = EventListColor.sectionHeaderBackground
        
    }
    
    
    func createConstraints(){
        
        sectionNameLabel <- [
            Leading(EventListConstant.sectionHeaderLeadingPadding),
            Top(EventListConstant.sectionHeaderTopBottomPadding),
            Bottom(EventListConstant.sectionHeaderTopBottomPadding)
            
        ]
        
        
    }
}
