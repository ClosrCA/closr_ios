//
//  LoginViewController.swift
//  Closr
//
//  Created by Tao on 2017-02-01.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit
import EasyPeasy
import FBSDKCoreKit
import FBSDKLoginKit
import SwiftyJSON

enum LoginException: Error {
    case cancelled
    case profileFailLoading
    
    var localizedDescription: String {
        switch self {
        case .cancelled: return "Oops, proccess cancelled"
        case .profileFailLoading: return "Can not load profile at the moment"
        }
    }
}

protocol LoginControllerDelegate: class {
    func didFinishLogin(loginController: LoginViewController)
    func didFailLogin(loginController: LoginViewController, withError error: Error)
}

class LoginViewController: UIViewController {
    
    struct Constants {
        static let logoTopPadding: CGFloat  = 200
        static let logoSize: CGSize         = CGSize(width: 266, height: 196)
        
        static let termsLabelPadding: CGFloat        = 8
        static let facebookButtonBottomPadding: CGFloat = 50
    }
    
    weak var delegate: LoginControllerDelegate?
    
    fileprivate lazy var backgroundImageView: UIImageView   = UIImageView(image: UIImage(named:"login_bg"))
    fileprivate lazy var backgroundOverlay: UIImageView     = UIImageView(image: UIImage(named: "login_bg_overlay"))
    fileprivate lazy var logoImageView: UIImageView         = UIImageView(image: UIImage(named: "login_logo"))
    
    fileprivate lazy var facebookLoginButton: UIButton = {
        let loginButton = UIButton()
        
        loginButton.setImage(UIImage(named: "login_facebook"), for: .normal)
        loginButton.addTarget(self, action: #selector(didTapFacebookLogin(sender:)), for: .touchUpInside)
        
        return loginButton
    }()
    
    fileprivate lazy var termsLabel: UILabel = {
        let termsLabel = UILabel()
        
        let textString = NSLocalizedString("By signing in you agree with our ", comment: "")
        let highlightedString = NSLocalizedString("Terms", comment: "")
        let theRest = NSLocalizedString(" of use", comment: "")
        
        let attributedString = NSMutableAttributedString(string: textString, attributes: [NSForegroundColorAttributeName: AppColor.lightGreyText,
                                                                                          NSFontAttributeName: AppFont.smallText])
        
        attributedString.append(NSAttributedString(string: highlightedString, attributes: [NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue,
                                                                                           NSForegroundColorAttributeName: AppColor.hightedText,
                                                                                           NSFontAttributeName: AppFont.smallText]))
        
        attributedString.append(NSAttributedString(string: theRest, attributes: [NSForegroundColorAttributeName: AppColor.lightGreyText,
                                                                                 NSFontAttributeName: AppFont.smallText]))
        
        termsLabel.numberOfLines    = 0
        termsLabel.attributedText   = attributedString
        termsLabel.textAlignment    = .center
        
        return termsLabel
    }()
    
    fileprivate lazy var subtitleLable = UILabel.makeLabel(font: AppFont.title,
                                                           textColor: AppColor.hightedText,
                                                           text: NSLocalizedString("Build friendships, one table at a time", comment: ""))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(backgroundImageView)
        view.addSubview(backgroundOverlay)
        view.addSubview(logoImageView)
        view.addSubview(facebookLoginButton)
        view.addSubview(termsLabel)
        view.addSubview(subtitleLable)
        
        createConstraints()
    }
    
    fileprivate func createConstraints() {
        backgroundImageView <- Edges()
        backgroundOverlay   <- Edges()
        
        logoImageView <- [
            Size(Constants.logoSize),
            Top(Constants.logoTopPadding),
            CenterX()
        ]
        
        subtitleLable <- [
            Top().to(logoImageView),
            CenterX()
        ]
        
        termsLabel <- [
            Leading(Constants.termsLabelPadding),
            Trailing(Constants.termsLabelPadding),
            Top(Constants.termsLabelPadding).to(facebookLoginButton, .bottom)
        ]
        
        facebookLoginButton <- [
            Leading(),
            Trailing(),
            Bottom(Constants.facebookButtonBottomPadding)
        ]
    }
    
    @objc
    fileprivate func didTapFacebookLogin(sender: UIButton) {
        
        loginWithFacebook(success: { [unowned self] in
            
            self.loadFacebookProfile(success: { 
                self.delegate?.didFinishLogin(loginController: self)
                
            }, failure: { (error) in
                
                self.delegate?.didFailLogin(loginController: self, withError: error)
            })
            
        }, cancellation: { [unowned self] in
            
            self.delegate?.didFailLogin(loginController: self, withError: LoginException.cancelled)
            
        }) { [unowned self] (error) in
            
            self.delegate?.didFailLogin(loginController: self, withError: error)
            
        }
    }
    
    fileprivate func loginWithFacebook(success: (() -> Void)?, cancellation: (() -> Void)?, failure: ((Error) -> Void)?) {
        
        FBSDKLoginManager().logIn(withReadPermissions: ["public_profile", "email", "user_friends", "user_birthday"], from: self) { (loginResult, error) in
            
            if let error = error {
                
                failure?(error)
                
                return
            }
            
            if let cancelled = loginResult?.isCancelled, cancelled {
                cancellation?()
                
                return
            }
            
            success?()
        }
    }
    
    fileprivate func loadFacebookProfile(success: (() -> Void)?, failure: ((Error) -> Void)?) {
        
        FBSDKGraphRequest(graphPath: "me",
                          parameters: ["fields": "email, name, gender, birthday, picture.type(large)"],
                          tokenString: FBSDKAccessToken.current().tokenString,
                          version: "v2.8",
                          httpMethod: "GET").start { (connection, response, error) in
                            
                            if let error = error {
                                failure?(error)
                                return
                            }
                            
                            if let response = response {
                                
                                User(profile: JSON(response)).store()
                                
                                success?()
                                return
                            }
                            
        }
    }

}
