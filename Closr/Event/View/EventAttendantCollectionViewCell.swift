//
//  EventCollectionViewCell.swift
//  Closr
//
//  Created by ZHITAO TIAN on 2017-03-25.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit
import EasyPeasy

class EventAttendantCollectionViewCell: UICollectionViewCell, Reusable {
    
    static let preferredSize: CGSize = CGSize(width: 65, height: 95)
    
    fileprivate lazy var attendantImageView: UIImageView = {
        let imageView           = UIImageView()
        imageView.contentMode   = .scaleAspectFill
        
        return imageView
    }()
    
    fileprivate var nameLabel: UILabel = UILabel.makeLabel(font: AppFont.smallText, textColor: AppColor.text_dark)
    
    fileprivate var hostTagLabel: UILabel = UILabel.makeLabel(font: AppFont.smallText, textColor: AppColor.brand)
    
    func update(with imageURL: String? = nil, name: String? = nil, isHost: Bool = false) {
        
        attendantImageView.loadImage(URLString: imageURL, placeholder: UIImage(named: "icon_user"))
        
        nameLabel.text = name
        
        hostTagLabel.text = isHost ? "Host" : nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(attendantImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(hostTagLabel)
        
        createConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        attendantImageView.cancelLoading()
        nameLabel.text      = nil
        hostTagLabel.text   = nil
    }
    
    fileprivate func createConstraints() {
        
        attendantImageView <- [
            Top(),
            Leading(),
            Trailing(),
            Height().like(attendantImageView, .width)
        ]
        
        nameLabel <- [
            Top(AppSizeMetric.defaultPadding).to(attendantImageView),
            Leading(),
            Trailing()
        ]
        
        hostTagLabel <- [
            Top().to(nameLabel),
            Leading(),
            Trailing(),
            Bottom(>=0)
        ]
    }
}
