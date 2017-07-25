//
//  MyEventViewController.swift
//  Closr
//
//  Created by Yale的Mac on 2017/7/5.
//  Copyright © 2017年 closr. All rights reserved.
//

import UIKit
import EasyPeasy

class MyEventViewController: UIViewController {
    
    fileprivate lazy var tableView: UITableView = {
        let tableView                   = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource            = self
        tableView.estimatedRowHeight    = 200
        tableView.rowHeight             = UITableViewAutomaticDimension
        tableView.separatorStyle        = .none
        tableView.sectionFooterHeight   = 0
        tableView.backgroundColor       = .white

        tableView.register(MyEventTableViewCell.self, forCellReuseIdentifier: MyEventTableViewCell.reuseIdentifier)
        return tableView
    }()


    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView <- Edges()
    }
}

extension MyEventViewController: UITableViewDataSource {

    enum MyEventSection: Int {
        
        static let count = 3
        
        case joined
        case hosted
        case past
        
        var header: String {
            switch self {
            case .joined:
                return "Joined Events"
            case .hosted:
                return "Hosted History"
            case .past:
                return "Past Event"
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return MyEventSection.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let section = MyEventSection(rawValue: section)!
        
        switch section {
        case .joined:
            return 1
        case .hosted:
            return 1
        case .past:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let section = MyEventSection(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        
        switch section {
        case .joined:
            let cell = tableView.dequeueReusableCell(withIdentifier: MyEventTableViewCell.reuseIdentifier, for: indexPath) as! MyEventTableViewCell
            
            return cell
        case .hosted:
            let cell = tableView.dequeueReusableCell(withIdentifier: MyEventTableViewCell.reuseIdentifier, for: indexPath) as! MyEventTableViewCell
            
            return cell
        case .past:
            let cell = tableView.dequeueReusableCell(withIdentifier: MyEventTableViewCell.reuseIdentifier, for: indexPath) as! MyEventTableViewCell
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        guard let section = MyEventSection(rawValue: section) else {
            return nil
        }
        
        return section.header
    }


}
