//
//  MyProfileViewController.swift
//  Closr
//
//  Created by ZHITAO TIAN on 2017-08-26.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit
import EasyPeasy

protocol MyProfileViewControllerDelegate: class {
    func didSelectConfirm(controller: MyProfileViewController)
}

class MyProfileViewController: UIViewController {

    var isConfirming: Bool = false
    
    var user: User?
    
    weak var delegate: MyProfileViewControllerDelegate?
    
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        return tableView
    }()
    
    fileprivate (set) lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("Get Started", for: .normal)
        button.titleLabel?.font = AppFont.title
        button.setTitleColor(.white, for: .normal)
        button.setBackgroundColor(color: AppColor.brand, for: .normal)
        button.addTarget(self, action: #selector(onConfirm), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "log out", style: .done, target: self, action: #selector(logout))
        
        view.addSubview(tableView)
        
        tableView <- Edges()
        
        setupProfileHeader()
        setupFooterIfNeeded()
    }
    
    fileprivate func setupProfileHeader() {
        let profileHeader = ProfileAvatarHeaderView(frame: CGRect(x: 0, y: 0, width: 0, height: 200))
        profileHeader.update(avatarURL: user?.avatar, showMenu: !isConfirming)
        tableView.tableHeaderView = profileHeader
    }
    
    fileprivate func setupFooterIfNeeded() {
        if isConfirming {
            confirmButton.frame         = CGRect(x: 0, y: 0, width: 0, height: 40)
            tableView.tableFooterView   = confirmButton
        }
    }
    
    @objc
    fileprivate func logout() {
        NotificationCenter.default.post(name: NotificationName.signout, object: nil)
    }
    
    @objc
    fileprivate func onConfirm() {
        delegate?.didSelectConfirm(controller: self)
    }

}
