//
//  ProfileAvatarHeaderView.swift
//  Closr
//
//  Created by Tao on 2017-03-29.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit
import EasyPeasy

protocol ProfileAvatarHeaderViewDelegate: class {
    func didSelectEditAvatar()
}

class ProfileAvatarHeaderView: UIView {

    static let preferredHeight: CGFloat = 230
    
    weak var delegate: ProfileAvatarHeaderViewDelegate?
    
    fileprivate struct Constants {
        static let avatarSize: CGSize           = CGSize(width: 126, height: 126)
        static let avatarTopPadding: CGFloat    = 60
        
        static let editButtonSize: CGSize       = CGSize(width: 40, height: 40)
    }
    
    fileprivate lazy var avatarImageView: UIImageView = {
        let imageView                   = UIImageView()
        imageView.layer.cornerRadius    = Constants.avatarSize.height / 2
        imageView.clipsToBounds         = true
        
        return imageView
    }()
    
    fileprivate lazy var editButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "icon_pencil"), for: .normal)
        button.addTarget(self, action: #selector(selectEdit), for: .touchUpInside)
        
        return button
    }()
    
    fileprivate lazy var moreButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "icon_menu"), for: .normal)
        button.addTarget(self, action: #selector(selectEdit), for: .touchUpInside)
        
        return button
    }()
    
    func update(avatarURL: String?, showMenu: Bool) {
        avatarImageView.loadImage(URLString: avatarURL, placeholder: UIImage(named: "icon_user"))
        moreButton.isHidden = !showMenu
    }
    
    func update(avatarImage: UIImage) {
        avatarImageView.image = avatarImage
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(avatarImageView)
        addSubview(editButton)
        addSubview(moreButton)
        
        createConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func createConstraints() {
        avatarImageView <- [
            Top(Constants.avatarTopPadding),
            CenterX(),
            Size(Constants.avatarSize)
        ]
        
        editButton <- [
            Leading(AppSizeMetric.breathPadding).to(avatarImageView),
            CenterY().to(avatarImageView)
        ]
        
        moreButton <- [
            Top(Constants.avatarTopPadding),
            Trailing(AppSizeMetric.breathPadding)
        ]
    }
    
    @objc
    fileprivate func selectEdit() {
        delegate?.didSelectEditAvatar()
    }
    
    @objc
    fileprivate func selectMore() {
        
    }
}
