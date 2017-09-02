//
//  MyProfileViewController.swift
//  Closr
//
//  Created by ZHITAO TIAN on 2017-08-26.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit

class MyProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "log out", style: .done, target: self, action: #selector(logout))
    }
    
    @objc
    fileprivate func logout() {
        NotificationCenter.default.post(name: NotificationName.signout, object: nil)
    }

}
