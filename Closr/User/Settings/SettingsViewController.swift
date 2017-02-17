//
//  SettingsViewController.swift
//  Closr
//
//  Created by Zhitao on 2017-02-17.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Log Out"
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        NotificationCenter.default.post(name: NotificationName.signout, object: nil)
    }
}
