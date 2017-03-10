//
//  RestaurantTableViewController.swift
//  Closr
//
//  Created by Yale的Mac on 2017/2/27.
//  Copyright © 2017年 YaleMac. All rights reserved.
//

import UIKit

class RestaurantTableViewController: UITableViewController {
    
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        
        
        tableView.register(RestaurantTableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        
        
        
        tableView.delegate=self
        tableView.dataSource=self
        
       
        
        
        if Device.is_3_5_inches || Device.is_4_inches {
            self.tableView.rowHeight=112.5
        }
        
        if Device.is_4_7_inches {
            self.tableView.rowHeight=132.5
        }
        if Device.is_5_5_inches{
            
            self.tableView.rowHeight=146
            
        }
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        // Configure the cell...
        
        return cell
    }
    
    
       
}



