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
    
    fileprivate lazy var loginController: LoginViewController = {
        let loginController         = LoginViewController()
        loginController.delegate    = self
        
        return loginController
    }()
    
    fileprivate lazy var profileConfirmController: ProfileViewController = {
        let confirmViewController       = ProfileViewController()
        confirmViewController.user      = User.currentUser
        confirmViewController.delegate  = self
        
        return confirmViewController
    }()
    
    fileprivate lazy var tabbarController: TabBarController = TabBarController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if User.isAuthenticated {
            display(controller: tabbarController)
        } else {
            display(controller: loginController)
        }
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

extension RootViewController: ProfileViewControllerDelegate {
    func profileViewControllerDidSelectConfirm(controller: ProfileViewController) {
        
        remove(controller: controller)
        
        display(controller: tabbarController)
    }
}

