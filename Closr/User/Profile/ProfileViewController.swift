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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(profileContainerView)
        
        if let user = user {
            profileContainerView.updateWith(user: user)
        }
        
        createConstraints()
    }
    
    fileprivate func createConstraints() {
        profileContainerView <- Edges()
    }

}

extension ProfileViewController: ProfileContainerViewDelegate {
    
    func profileContainerViewDidSelectConfirm(view: ProfileContainerView) {
        // TODO: render tab bar controller
    }
}
