//
//  PromotionViewController.swift
//  Closr
//
//  Created by ZHITAO TIAN on 2017-09-10.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit
import MapKit
import EasyPeasy

class PromotionViewController: UIViewController {

    fileprivate lazy var mapView: MKMapView = {
        let map = MKMapView()
        
        return map
    }()
    
    fileprivate lazy var zoomInButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "plus"), for: .normal)
        button.setBackgroundColor(color: .white, for: .normal)
        button.addTarget(self, action: #selector(zoomIn), for: .touchUpInside)
        
        return button
    }()
    
    fileprivate lazy var zoomOutButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "minus"), for: .normal)
        button.setBackgroundColor(color: .white, for: .normal)
        button.addTarget(self, action: #selector(zoomOut), for: .touchUpInside)
        
        return button
    }()
    
    fileprivate lazy var carouselController: PromotionCarouselController = PromotionCarouselController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildViewController(carouselController)
        view.addSubview(carouselController.view)
        carouselController.didMove(toParentViewController: self)
        
        view.addSubview(mapView)
        view.addSubview(zoomInButton)
        view.addSubview(zoomOutButton)
        
        createConstraints()
    }
    
    fileprivate func createConstraints() {
        mapView <- [
            Top(),
            Leading(),
            Trailing(),
            Height(275)
        ]
        
        zoomInButton <- [
            Size(24),
            Top(AppSizeMetric.breathPadding),
            Trailing(AppSizeMetric.breathPadding)
        ]
        
        zoomOutButton <- [
            Size(24),
            Top(AppSizeMetric.breathPadding).to(zoomInButton),
            Trailing(AppSizeMetric.breathPadding)
        ]
        
        carouselController.view <- [
            Top().to(mapView),
            Leading(),
            Trailing(),
            Bottom()
        ]
    }
    
    @objc
    fileprivate func zoomIn() {
        
    }
    
    @objc
    fileprivate func zoomOut() {
        
    }

}
