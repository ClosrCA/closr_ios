//
//  ProfileViewController.swift
//  Closr
//
//  Created by Tao on 2017-02-12.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit
import EasyPeasy

class ProfileViewController: UIViewController {

    var user: User?
    
    lazy var profileContainerView: ProfileContainerView = {
        let containerView                                       = ProfileContainerView(frame: .zero)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.delegate                                  = self
        
        return containerView
    }()
    
    fileprivate lazy var keyboardObserver = KeyboardObserver()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(profileContainerView)
        
        if let user = user {
            profileContainerView.updateWith(user: user)
        }
        
        createConstraints()
        
        addKeyboardObserver()
    }
    
    fileprivate func createConstraints() {
        profileContainerView <- Edges()
    }
    
    fileprivate func addKeyboardObserver() {
        
        keyboardObserver.addObserver(didAppear: { [weak self] (size) in
            
            guard let weakSelf = self else {
                return
            }
            
            UIView.animate(withDuration: 2.0, animations: {
                
                weakSelf.profileContainerView <- [
                    Top(-size.height),
                    Bottom(-size.height)
                ]
                
                weakSelf.view.layoutIfNeeded()
                
            })
            
        }) { [weak self] (size) in
            
            guard let weakSelf = self else {
                return
            }
            
            UIView.animate(withDuration: 2.0, animations: {
                
                weakSelf.profileContainerView <- [
                    Top(),
                    Bottom()
                ]
                
                weakSelf.view.layoutIfNeeded()
            })
        }
    }

}

extension ProfileViewController: ProfileContainerViewDelegate {
    
    func profileContainerViewDidSelectConfirm(view: ProfileContainerView) {
        // TODO: render tab bar controller
    }
}
