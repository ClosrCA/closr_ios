//
//  ProfileViewController.swift
//  Closr
//
//  Created by Zhitao on 2017-02-17.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        buildNavigationItems()
    }

    fileprivate func buildNavigationItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Settings", style: .done, target: self, action: #selector(onSettings))
    }
    
    @objc
    fileprivate func onSettings() {
        
        let settingsViewController = SettingsViewController(style: .grouped)
        navigationController?.pushViewController(settingsViewController, animated: true)
    }
}
