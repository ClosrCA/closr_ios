//
//  ProfileContainerView.swift
//  Closr
//
//  Created by Tao on 2017-02-12.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit
import EasyPeasy

protocol ProfileContainerViewDelegate: class {
    func profileContainerViewDidSelectConfirm(view: ProfileContainerView)
}

class ProfileContainerView: UIView {
    
    weak var delegate: ProfileContainerViewDelegate?

    func updateWith(user: User) {
        
        nameLabel.text          = user.name
        
        if let birthday = user.birthday {
            let formatter = DateFormatter()
            formatter.dateFormat = String.birthdayFormat
            birthDayTextField.text = formatter.string(from: birthday)
        }
        
        genderTextField.text    = user.gender?.title
        emailTextField.text     = user.email
        phoneTextField.text     = user.phone
        
        phoneTextField.placeholder = "Optional"
        
        if let avatar = user.avatar {
            avatarImageView.loadImage(URLString: avatar, placeholder: nil)
        }
    }
    
    fileprivate (set) lazy var avatarImageView: UIImageView = {
        let imageView                                       = UIImageView()
        imageView.layer.cornerRadius                        = ProfileConstant.AvatarImage.size / 2
        imageView.layer.borderWidth                         = 1.0
        imageView.layer.borderColor                         = AppColor.lightGreyText.cgColor
        imageView.clipsToBounds                             = true
        // TODO: internal light border
        
        return imageView
    }()
    
    fileprivate (set) lazy var nameLabel: UILabel = {
        let label                                       = UILabel()
        label.font                                      = AppFont.title
        label.textColor                                 = AppColor.title
        label.numberOfLines                             = 0
        
        return label
    }()
    
    fileprivate (set) lazy var birthDayTextField: UITextField   = self.makeTextFieldWith(icon: UIImage(named: "birthday")!,
                                                                                         backgroundColor: AppColor.greyBackground,
                                                                                         textColor: AppColor.greyText,
                                                                                         editable: false)
    
    fileprivate (set) lazy var genderTextField: UITextField     = self.makeTextFieldWith(icon: UIImage(named: "gender")!,
                                                                                         backgroundColor: AppColor.greyBackground,
                                                                                         textColor: AppColor.greyText,
                                                                                         editable: false)
    
    fileprivate (set) lazy var emailTextField: UITextField      = self.makeTextFieldWith(icon: UIImage(named: "email")!,
                                                                                         backgroundColor: AppColor.greyBackground,
                                                                                         textColor: AppColor.greyText,
                                                                                         editable: true)
    
    fileprivate (set) lazy var phoneTextField: UITextField      = self.makeTextFieldWith(icon: UIImage(named: "phone")!,
                                                                                         backgroundColor: AppColor.greyBackground,
                                                                                         textColor: AppColor.greyText,
                                                                                         editable: true)
    
    fileprivate (set) lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("Get Closr", for: .normal)
        button.titleLabel?.font = AppFont.title
        button.setTitleColor(.white, for: .normal)
        button.setBackgroundImage(UIImage.imageWith(color: AppColor.brand, within: CGSize(width: 1, height: 1)), for: .normal)
        button.addTarget(self, action: #selector(onConfirm), for: .touchUpInside)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
        
        addSubview(avatarImageView)
        addSubview(nameLabel)
        addSubview(birthDayTextField)
        addSubview(genderTextField)
        addSubview(emailTextField)
        addSubview(phoneTextField)
        addSubview(confirmButton)
        
        createConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func createConstraints() {
        
        avatarImageView <- [
            Top(ProfileConstant.AvatarImage.topPadding),
            CenterX(),
            Bottom(ProfileConstant.AvatarImage.bottomPadding).to(nameLabel, .top),
            Size(ProfileConstant.AvatarImage.size)
        ]
        
        nameLabel <- [
            CenterX(),
            Bottom(ProfileConstant.NameLabel.bottomPadding).to(birthDayTextField, .top)
        ]
        
        birthDayTextField <- [
            Leading(ProfileConstant.TextField.horizontalPadding),
            Height(ProfileConstant.TextField.height),
            Width().like(genderTextField),
            Trailing(ProfileConstant.TextField.horizontalPadding).to(genderTextField, .leading)
        ]
        
        genderTextField <- [
            Trailing(ProfileConstant.TextField.horizontalPadding),
            Height(ProfileConstant.TextField.height),
            Top().to(birthDayTextField, .top),
            Bottom(ProfileConstant.TextField.verticalPadding).to(emailTextField, .top)
        ]
        
        emailTextField <- [
            Leading(ProfileConstant.TextField.horizontalPadding),
            Trailing(ProfileConstant.TextField.horizontalPadding),
            Height(ProfileConstant.TextField.height),
            Bottom(ProfileConstant.TextField.verticalPadding).to(phoneTextField, .top)
        ]
        
        phoneTextField <- [
            Leading(ProfileConstant.TextField.horizontalPadding),
            Trailing(ProfileConstant.TextField.horizontalPadding),
            Height(ProfileConstant.TextField.height),
            Bottom(ProfileConstant.TextField.verticalPadding).to(confirmButton, .top)
        ]
        
        confirmButton <- [
            Leading().to(phoneTextField, .leading),
            Trailing().to(phoneTextField, .trailing),
            Height(ProfileConstant.ConfirmButton.height)
        ]
    }
    
    fileprivate func makeTextFieldWith(icon: UIImage, backgroundColor: UIColor, textColor: UIColor, editable: Bool, placeholder: String? = nil) -> UITextField {
        
        let textField                                       = UITextField()
        textField.font                                      = AppFont.text
        textField.textColor                                 = textColor
        textField.tintColor                                 = textColor
        textField.backgroundColor                           = backgroundColor
        textField.leftView                                  = makeLeftViewFrom(icon: icon)
        textField.leftViewMode                              = .always
        textField.placeholder                               = placeholder
        textField.isUserInteractionEnabled                  = editable
        
        return textField
    }
    
    fileprivate func makeLeftViewFrom(icon: UIImage) -> UIView {
        let imageView               = UIImageView(image: icon)
        
        let leftView                = UIView(frame: CGRect(x: 0, y: 0, width: ProfileConstant.TextField.height, height: ProfileConstant.TextField.height))
        leftView.backgroundColor    = UIColor.clear
        leftView.addSubview(imageView)
        
        imageView <- [
            Center(),
            Size(ProfileConstant.TextField.iconSize)
        ]
        
        return leftView
    }
    
    @objc
    fileprivate func onConfirm() {
        delegate?.profileContainerViewDidSelectConfirm(view: self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        birthDayTextField.resignFirstResponder()
        genderTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        phoneTextField.resignFirstResponder()
    }
}
