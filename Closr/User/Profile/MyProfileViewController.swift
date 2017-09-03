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

enum Form: Int {
    case name
    case email
    case birthday
    case phone
    
    var title: String {
        switch self {
        case .name:
            return "Name"
        case .email:
            return "Email"
        case .birthday:
            return "Birthday"
        case .phone:
            return "Phone number"
        }
    }
    
    var keyboardType: UIKeyboardType {
        switch self {
        case .name, .birthday:
            return .default
        case .email:
            return .emailAddress
        case .phone:
            return .phonePad
        }
    }
}

class MyProfileViewController: UIViewController {

    var isConfirming: Bool = false
    
    var user: User?
    
    weak var delegate: MyProfileViewControllerDelegate?
    
    fileprivate lazy var tableView: UITableView = {
        let tableView                   = UITableView()
        tableView.dataSource            = self
        tableView.delegate              = self
        tableView.estimatedRowHeight    = 40
        tableView.rowHeight             = UITableViewAutomaticDimension
        tableView.separatorStyle        = .none
        
        tableView.register(ProfileFormTableViewCell.self, forCellReuseIdentifier: ProfileFormTableViewCell.reuseIdentifier)
        
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
        
        tableView.reloadData()
    }
    
    fileprivate func setupProfileHeader() {
        let profileHeader = ProfileAvatarHeaderView(frame: CGRect(x: 0, y: 0, width: 0, height: ProfileAvatarHeaderView.preferredHeight))
        profileHeader.update(avatarURL: user?.avatar, showMenu: !isConfirming)
        tableView.tableHeaderView = profileHeader
    }
    
    fileprivate func setupFooterIfNeeded() {
        if isConfirming {
            view.addSubview(confirmButton)
            
            confirmButton <- [
                Leading(),
                Bottom(),
                Trailing(),
                Height(AppSizeMetric.buttonHeight)
            ]
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

extension MyProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileFormTableViewCell.reuseIdentifier, for: indexPath) as! ProfileFormTableViewCell
        
        cell.dataSource = self
        cell.delegate   = self
        
        return cell
    }
}

extension MyProfileViewController: ProfileFormTableViewCellDataSource, ProfileFormTableViewCellDelegate {
    func title(for cell: ProfileFormTableViewCell) -> String? {
        
        return form(from: cell)?.title
    }
    
    func text(for cell: ProfileFormTableViewCell) -> String? {
        guard let form = form(from: cell) else {
            return nil
        }
        
        switch form {
        case .name:
            return user?.name
        case .email:
            return user?.email
        case .birthday:
            return user?.birthday?.description
        case .phone:
            return user?.phone
        }
    }
    
    func keyboardType(for cell: ProfileFormTableViewCell) -> UIKeyboardType {
        return form(from: cell)?.keyboardType ?? .default
    }
    
    func inputView(for cell: ProfileFormTableViewCell) -> UIView? {
        return nil
    }
    
    func inputAccesaryView(for cell: ProfileFormTableViewCell) -> UIView? {
        return nil
    }
    
    func didReturn(from cell: ProfileFormTableViewCell) {
        
    }
    
    func didEndEditing(from cell: ProfileFormTableViewCell) {
        
    }
    
    fileprivate func form(from cell: ProfileFormTableViewCell) -> Form? {
        guard let row = tableView.indexPathForRow(at: cell.center)?.row else {
            return nil
        }
        
        return Form(rawValue: row)
    }
}
