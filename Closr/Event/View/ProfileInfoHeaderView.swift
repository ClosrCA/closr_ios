//
//  ProfileInfoHeaderView.swift
//  Closr
//
//  Created by Tao on 2017-03-29.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit
import EasyPeasy

class ProfileInfoHeaderView: UITableViewHeaderFooterView {

    struct Constants {
        static let contentPadding: CGFloat  = 20
        
        static let avatarImageSize: CGFloat     = 80
        static let avatarBorderWidth: CGFloat   = 2
        
        static let genderImageSize: CGFloat = 20
        
        static let nameLabelVerticalPadding: CGFloat = 20
        static let infoLabelVerticalPadding: CGFloat = 10
    }
    
    fileprivate lazy var avatarImageView: UIImageView = {
        let imageView                   = UIImageView()
        imageView.layer.cornerRadius    = Constants.avatarImageSize / 2
        imageView.layer.borderColor     = AppColor.brand.cgColor
        imageView.layer.borderWidth     = Constants.avatarBorderWidth
        
        return imageView
    }()
    
    fileprivate lazy var genderImageView: UIImageView = UIImageView()

    fileprivate lazy var nameLabel: UILabel = UILabel.makeLabel(font: AppFont.title, textColor: AppColor.brand)
    
    fileprivate lazy var birthdayLabel: UILabel = UILabel.makeLabel(font: AppFont.smallText, textColor: AppColor.text_gray)
    
    fileprivate lazy var phoneLabel: UILabel = UILabel.makeLabel(font: AppFont.smallText, textColor: AppColor.text_gray)
    
    fileprivate lazy var emailLabel: UILabel = UILabel.makeLabel(font: AppFont.smallText, textColor: AppColor.text_gray)
    
    func update(user: User) {
        // TODO: avatar placeholder
        avatarImageView.loadImage(URLString: user.avatar, placeholder: nil)
        nameLabel.text = user.name
        
        if let birthday = user.birthday {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = String.birthdayFormat
            birthdayLabel.text = dateFormatter.string(from: birthday)
        }
        
        phoneLabel.text = user.phone
        emailLabel.text = user.email
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(avatarImageView)
        contentView.addSubview(genderImageView)
        contentView.addSubview(birthdayLabel)
        contentView.addSubview(phoneLabel)
        contentView.addSubview(emailLabel)
        
        createConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func createConstraints() {
        avatarImageView <- [
            Top(Constants.contentPadding),
            Leading(Constants.contentPadding),
            Bottom(Constants.contentPadding),
            Size(Constants.avatarImageSize)
        ]
        
        nameLabel <- [
            Top(Constants.nameLabelVerticalPadding),
            Leading(Constants.contentPadding).to(avatarImageView),
            Trailing(>=0).to(genderImageView)
        ]
        
        genderImageView <- [
            Trailing(Constants.contentPadding),
            Top(Constants.contentPadding),
            Size(Constants.genderImageSize)
        ]
        
        birthdayLabel <- [
            Leading().to(nameLabel, .leading),
            Top(Constants.nameLabelVerticalPadding).to(nameLabel)
        ]
        
        phoneLabel <- [
            Leading().to(nameLabel, .leading),
            Top(Constants.infoLabelVerticalPadding).to(birthdayLabel)
        ]
        
        emailLabel <- [
            Leading().to(nameLabel, .leading),
            Top(Constants.infoLabelVerticalPadding).to(phoneLabel)
        ]
    }
}
