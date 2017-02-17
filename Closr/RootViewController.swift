//
//  RootViewController.swift
//  Closr
//
//  Created by Tao on 2017-01-25.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit
import CoreLocation

class RootViewController: UIViewController {
    
    fileprivate lazy var demoTableViewController: UINavigationController = {
        let storyboard = UIStoryboard(name: "Places", bundle: nil)
        
        let controller = storyboard.instantiateViewController(withIdentifier: "PlaceController") as! PlacesTableViewController
        
        return UINavigationController(rootViewController: controller)
    }()
    
    fileprivate var loginController: LoginViewController {
        let loginController         = LoginViewController()
        loginController.delegate    = self
        
        return loginController
    }
    
    fileprivate var profileConfirmController: ProfileConfirmViewController {
        let confirmViewController       = ProfileConfirmViewController()
        confirmViewController.user      = User.currentUser
        confirmViewController.delegate  = self
        
        return confirmViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if User.isAuthenticated {
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
        
        childViewControllers.forEach { remove(controller: $0) }
        
        User.clear()
        
        display(controller: loginController)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension RootViewController: LoginControllerDelegate {
    
    func didFinishLogin(loginController: LoginViewController) {
        
        remove(controller: loginController)
        
        display(controller: profileConfirmController)
    }
    
    func didFailLogin(loginController: LoginViewController, withError error: Error) {
        
        let alertController = UIAlertController(title: nil, message: error.localizedDescription, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel))
        
        present(alertController, animated: true)
    }
}

extension RootViewController: ProfileConfirmViewControllerDelegate {
    func profileConfirmViewControllerDidSelectConfirm(controller: ProfileConfirmViewController) {
        
        remove(controller: controller)
        
        let tabBarController = TabBarController()
        display(controller: tabBarController)
    }
}

