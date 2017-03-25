//
//  EventCollectionViewCell.swift
//  Closr
//
//  Created by ZHITAO TIAN on 2017-03-25.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit
import EasyPeasy

class EventCollectionViewCell: UICollectionViewCell {
    
    // TODO: - replace 
    
    fileprivate lazy var thumbnail: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.brand
        
        return view
    }()
    
    fileprivate lazy var titleLabel: UILabel = UILabel.makeLable(font: AppFont.thinTitle, textColor: AppColor.title)
}
