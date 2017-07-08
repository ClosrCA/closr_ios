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
        let tableView                   = UITableView()
        tableView.dataSource            = self
        tableView.estimatedRowHeight    = 200
        tableView.rowHeight             = UITableViewAutomaticDimension

        tableView.register(MyEventTableViewCell.self, forCellReuseIdentifier: MyEventTableViewCell.reuseIdentifier)
        return tableView
    }()


    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView <- Edges()
  
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   
}

extension MyEventViewController: UITableViewDataSource{

    
    enum MyEventSection: Int {
        case joined
        case hosted
        case past
        case count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return MyEventSection.count.rawValue
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
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = MyEventSection(rawValue: indexPath.section)!
        
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
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let section = MyEventSection(rawValue: section)!
        
        
        switch section {
        case .joined:
            return "Joined Events"
        case .hosted:
            return "Hosted History"
        case .past:
            return "Past Event"
        default:
            return nil
        }
    }


}
