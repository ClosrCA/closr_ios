//
//  SettingsTableViewController.swift
//  Closr
//
//  Created by ZHITAO TIAN on 2017-09-03.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    enum Settings: Int {
        
        static let count = 4
        
        case support
        case FAQ
        case terms
        case logout
        
        var title: String {
            switch self {
            case .support:
                return "Support"
            case .FAQ:
                return "FAQ"
            case .terms:
                return "Terms & Conditions"
            case .logout:
                return "Log out"
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView               = UIView()
        tableView.showsVerticalScrollIndicator  = false
        tableView.isScrollEnabled               = false
        
        preferredContentSize = CGSize(width: 185, height: 175)
    }
    
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Settings.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        let setting             = Settings(rawValue: indexPath.row)
        cell.textLabel?.text    = setting?.title
        cell.selectionStyle     = .none

        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let setting = Settings(rawValue: indexPath.row) {
            switch setting {
            case .logout:
                presentingViewController?.dismiss(animated: true) {
                    NotificationCenter.default.post(name: NotificationName.signout, object: nil)
                }
            default:
                break
            }
        }
    }

}
