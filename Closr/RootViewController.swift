//
//  RootViewController.swift
//  Closr
//
//  Created by Tao on 2017-01-25.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit
import CoreLocation
import FirebaseAuth

class RootViewController: UIViewController {
    
    fileprivate var loginController: LoginViewController {
        let loginController         = LoginViewController()
        loginController.delegate    = self
        
        return loginController
    }
    
    fileprivate var profileConfirmController: MyProfileViewController {
        let confirmViewController           = MyProfileViewController()
        confirmViewController.isConfirming  = true
        confirmViewController.user          = User.current
        confirmViewController.delegate      = self
        
        return confirmViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let authUser = Auth.auth().currentUser {
            
            prepopulateProfileBeforeFetch(authUser: authUser)
            
            let tabBarController = TabBarController()
            display(controller: tabBarController)
        } else {
            display(controller: loginController)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(didSignout), name: NotificationName.signout, object: nil)
    }
    
    fileprivate func remove(controller: UIViewController) {
        controller.willMove(toParentViewController: nil)
        controller.view.removeFromSuperview()
        controller.removeFromParentViewController()
    }
    
    fileprivate func display(controller: UIViewController) {
        addChildViewController(controller)
        controller.view.frame = view.bounds
        view.addSubview(controller.view)
        controller.didMove(toParentViewController: self)
    }
    
    @objc
    fileprivate func didSignout() {
        
        do {
            try User.logout()
            childViewControllers.forEach { remove(controller: $0) }
            display(controller: loginController)
        } catch {
            let alertController = UIAlertController(title: "Opps", message: error.localizedDescription, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .default))
            present(alertController, animated: true)
        }
    }
    
    fileprivate func prepopulateProfileBeforeFetch(authUser: FirebaseAuth.User) {
        if let providerData = authUser.providerData.first {
            User.current = User(userInfo: providerData)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension RootViewController: LoginControllerDelegate {
    
    func didFinishLogin(loginController: LoginViewController, needConfirm: Bool) {
        
        remove(controller: loginController)
        
        display(controller: needConfirm ? profileConfirmController : TabBarController())
    }
    
    func didFailLogin(loginController: LoginViewController, withError error: Error) {
        
        let alertController = UIAlertController(title: nil, message: error.localizedDescription, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel))
        
        present(alertController, animated: true)
    }
}

extension RootViewController: MyProfileViewControllerDelegate {
    func didSelectConfirm(controller: MyProfileViewController) {
        
        remove(controller: controller)
        
        let tabBarController = TabBarController()
        display(controller: tabBarController)
    }
}

