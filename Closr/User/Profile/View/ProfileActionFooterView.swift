//
//  ProfileActionFooterView.swift
//  Closr
//
//  Created by ZHITAO TIAN on 2017-03-26.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit
import EasyPeasy

protocol ProfileActionFooterViewDelegate: class {
    func profileActionFooterView(_ footer: ProfileActionFooterView, didSelectFAQ sender: UIButton)
    func profileActionFooterView(_ footer: ProfileActionFooterView, didSelectContact sender: UIButton)
    func profileActionFooterView(_ footer: ProfileActionFooterView, didSelectSignOut sender: UIButton)
}

class ProfileActionFooterView: UIView {
    
    static let preferredHeight: CGFloat = 138

    fileprivate struct Constants {
        static let buttonHeight: CGFloat = 44
        static let buttonPadding: CGFloat = 10
        static let footerContentPadding: CGFloat = 20
    }
    
    weak var delegate: ProfileActionFooterViewDelegate?
    
    fileprivate lazy var faqButton: UIButton = self.makeActionButton(title: "FAQ", action: #selector(onFAQSelected))
    fileprivate lazy var contactButton: UIButton = self.makeActionButton(title: "Contact Closr", action: #selector(onContactUsSelected))
    fileprivate lazy var signOutButton: UIButton = self.makeActionButton(title: "Sign Out", background: AppColor.background_gray, action: #selector(onSignOutSelected))
    
    fileprivate func makeActionButton(title: String, titleColor: UIColor = .white, background: UIColor = AppColor.brand, action: Selector) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.setBackgroundImage(UIImage.imageWith(color: background, within: CGSize(width: 1, height: 1)), for: .normal)
        
        button.layer.cornerRadius   = 10
        button.clipsToBounds        = true
        
        button.addTarget(self, action: action, for: .touchUpInside)
        
        return button
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(faqButton)
        addSubview(contactButton)
        addSubview(signOutButton)
        
        createConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    fileprivate func onFAQSelected() {
        delegate?.profileActionFooterView(self, didSelectFAQ: faqButton)
    }
    
    @objc
    fileprivate func onContactUsSelected() {
        delegate?.profileActionFooterView(self, didSelectContact: contactButton)
    }
    
    @objc
    fileprivate func onSignOutSelected() {
        delegate?.profileActionFooterView(self, didSelectSignOut: signOutButton)
    }
    
    fileprivate func createConstraints() {
        faqButton <- [
            Height(Constants.buttonHeight),
            Top(Constants.footerContentPadding),
            Leading(Constants.footerContentPadding),
            Width().like(contactButton)
        ]
        
        contactButton <- [
            Height(Constants.buttonHeight),
            Top(Constants.footerContentPadding),
            Trailing(Constants.footerContentPadding),
            Leading(Constants.buttonPadding).to(faqButton)
        ]
        
        signOutButton <- [
            Height(Constants.buttonHeight),
            Top(Constants.buttonPadding).to(faqButton),
            Leading(Constants.footerContentPadding),
            Trailing(Constants.footerContentPadding)
        ]
    }
        
}
