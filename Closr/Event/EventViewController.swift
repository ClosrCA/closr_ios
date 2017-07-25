//
//  EventViewController.swift
//  Closr
//
//  Created by ZHITAO TIAN on 2017-07-24.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit
import EasyPeasy

class EventViewController: UIViewController {

    fileprivate lazy var segmentControl: UISegmentedControl = {
        let control                     = UISegmentedControl(items: ["  Join Events  ", "  My Events  "])
        control.tintColor               = AppColor.brand
        control.selectedSegmentIndex    = 0
        
        control.addTarget(self, action: #selector(onSegmentedControl(sender:)), for: .valueChanged)
        
        return control
    }()
    
    fileprivate lazy var joinEventListController: JoinEventListViewController = JoinEventListViewController()
    
    fileprivate lazy var myEventListController: MyEventViewController = MyEventViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        navigationItem.titleView = segmentControl
        
        addChildViewController(joinEventListController)
        view.addSubview(joinEventListController.view)
        joinEventListController.didMove(toParentViewController: self)
    }
    
    @objc
    fileprivate func onSegmentedControl(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            cycleFrom(controller: myEventListController, to: joinEventListController)
        default:
            cycleFrom(controller: joinEventListController, to: myEventListController)
        }
        
        updateViewConstraints()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        if joinEventListController.parent != nil {
            joinEventListController.view <- Edges()
        }
        
        if myEventListController.parent != nil {
            myEventListController.view <- Edges()
        }
    }
}
