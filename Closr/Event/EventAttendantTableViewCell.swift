//
//  EventAttendantTableViewCell.swift
//  Closr
//
//  Created by ZHITAO TIAN on 2017-08-01.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit
import EasyPeasy

class EventAttendantTableViewCell: UITableViewCell {

    func update(with host: User, attendants: [User]) {
        
    }
    
    fileprivate func buildAttendant(with imageURL: String?, name: String?, ishost: Bool = false) -> UIView {
        let attendantView = UIView()
        
        let avatar = UIImageView()
        avatar.loadImage(URLString: imageURL, placeholder: UIImage(named: "user"))
        attendantView.addSubview(avatar)
        
        avatar <- [
            Size(AppSizeMetric.avatarSize),
            Top(),
            CenterX()
        ]
        
        if let username = name {
            let nameLabel = UILabel.makeLabel(font: AppFont.smallText, textColor: AppColor.text_dark, text: username)
            attendantView.addSubview(nameLabel)
            
            nameLabel <- [
                Top(AppSizeMetric.defaultPadding).to(avatar),
                CenterX()
            ]
            
            if ishost {
                let hostLabel = UILabel.makeLabel(font: AppFont.smallText, textColor: AppColor.brand, text: "Host")
                attendantView.addSubview(hostLabel)
                
                hostLabel <- [
                    Top().to(nameLabel),
                    CenterX()
                ]
            }
        }
        
        return attendantView
    }

}
