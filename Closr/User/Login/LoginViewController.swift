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
    

    weak var delegate: LoginControllerDelegate?
    
    fileprivate lazy var backgroundImageView: UIImageView = {
        if Device.is_3_5_inches || Device.is_4_inches {
            return UIImageView(image: UIImage(named:"login 5-5s-6.png"))
        }
            
        else if Device.is_4_7_inches {
             return UIImageView(image: UIImage(named:"login 6-6s-8.png"))
        }
        
        else{
             return UIImageView(image: UIImage(named:"login plus-05.png"))
        }
        
    }()
    
    
    
   
    
    fileprivate lazy var facebookLoginButton: UIButton = {
        let loginButton = UIButton()
        
        loginButton.setImage(UIImage(named: "login_facebook"), for: .normal)
        loginButton.addTarget(self, action: #selector(didTapFacebookLogin(sender:)), for: .touchUpInside)
        
        return loginButton
    }()
    
    fileprivate lazy var termsLabel: UILabel = {
        let termsLabel = UILabel()
        
        let textString = NSLocalizedString("By signing in you agree with our ", comment: "By signing in you agree with our")
        let highlightedString = NSLocalizedString("Terms", comment: "terms")
        let theRest = NSLocalizedString(" of use", comment: "of use")
        
        let attributedString = NSMutableAttributedString(string: textString, attributes: [NSForegroundColorAttributeName: LoginColor.termsRegular])
        attributedString.append(NSAttributedString(string: highlightedString, attributes: [NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue,
                                                                                           NSForegroundColorAttributeName: LoginColor.termsHighLight]))
        attributedString.append(NSAttributedString(string: theRest, attributes: [NSForegroundColorAttributeName: LoginColor.termsRegular]))
        
        termsLabel.numberOfLines = 0
        termsLabel.attributedText = attributedString
        
        return termsLabel
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(backgroundImageView)
        view.addSubview(facebookLoginButton)
        view.addSubview(termsLabel)
        
        
        createConstraints()
    }
    
    fileprivate func createConstraints() {
        backgroundImageView <- Edges()
        
        termsLabel <- [
            Leading(30),
            Trailing(30),
            Bottom(100),
            Top(30).to(facebookLoginButton, .bottom)
        ]
        
        facebookLoginButton <- [
            Leading(),
            Trailing(),
        ]
        
        
        if Device.is_3_5_inches || Device.is_4_inches {
            facebookLoginButton <- Bottom(185).to(backgroundImageView,.bottom)
        }
            
        else if Device.is_4_7_inches {
            facebookLoginButton <- Bottom(205).to(backgroundImageView,.bottom)

        }
            
        else{
            facebookLoginButton <- Bottom(240).to(backgroundImageView,.bottom)
        }
        

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
