//
//  RootViewController.swift
//  Closr
//
//  Created by Tao on 2017-01-25.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit
import CoreLocation

class RootViewController: UIViewController {
    
    lazy var demoTableViewController: PlacesTableViewController = {
        let storyboard = UIStoryboard(name: "Places", bundle: nil)
        
        return storyboard.instantiateViewController(withIdentifier: "PlaceController") as! PlacesTableViewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        demoTableViewController.willMove(toParentViewController: self)
        addChildViewController(demoTableViewController)
        view.addSubview(demoTableViewController.view)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        demoTableViewController.view.frame = view.bounds
    }

}

