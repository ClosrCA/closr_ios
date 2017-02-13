//
//  RootViewController.swift
//  Closr
//
//  Created by Tao on 2017-01-25.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit
import CoreLocation

class RootViewController: UIViewController, LoginControllerDelegate {
    
    fileprivate lazy var demoTableViewController: UINavigationController = {
        let storyboard = UIStoryboard(name: "Places", bundle: nil)
        
        let controller = storyboard.instantiateViewController(withIdentifier: "PlaceController") as! PlacesTableViewController
        
        return UINavigationController(rootViewController: controller)
    }()
    
    fileprivate lazy var loginController: LoginViewController = {
        let loginController = LoginViewController()
        loginController.delegate = self
        
        return loginController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        display(controller: loginController)
    }
    
    func didFinishLogin(loginController: LoginViewController) {
        
        remove(controller: loginController)
        
        let confirmViewController = ProfileViewController()
        confirmViewController.user = User.currentUser
        
        display(controller: confirmViewController)
    }
    
    func didFailLogin(loginController: LoginViewController, withError error: Error) {
        
        let alertController = UIAlertController(title: nil, message: error.localizedDescription, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel))
        
        present(alertController, animated: true)
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

