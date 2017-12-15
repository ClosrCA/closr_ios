//
//  LoadingViewController.swift
//  Closr
//
//  Created by ZHITAO TIAN on 2017-12-15.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit
import EasyPeasy

class LoadingViewController: UIViewController {

    fileprivate static let shared: LoadingViewController = LoadingViewController()
    
    static func startLoadingOn(_ viewController: UIViewController) {
        viewController.addChildViewController(shared)
        viewController.view.addSubview(shared.view)
        
        shared.startAnimation()
    }
    
    static func stopLoading() {
        shared.teardown()
    }
    
    fileprivate lazy var indicator: UIActivityIndicatorView = {
        let indicator           = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        indicator.tintColor     = AppColor.brand
        indicator.color         = AppColor.background_brand
        
        return indicator
    }()
    
    fileprivate lazy var indicatorBackground: UIView = {
        let view                    = UIView()
        view.backgroundColor        = AppColor.background_gray
        view.layer.cornerRadius     = 10
        view.clipsToBounds          = true
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        setupLoadingView()
    }
    
    fileprivate func setupLoadingView() {
        view.addSubview(indicatorBackground)
        view.addSubview(indicator)
        
        indicator <- Center()
        
        indicatorBackground <- [
            CenterY(),
            Leading(AppSizeMetric.breathPadding),
            Trailing(AppSizeMetric.breathPadding)
        ]
    }
    
    fileprivate func startAnimation() {
        indicator.fadeIn()
        indicator.startAnimating()
    }
    
    fileprivate func teardown() {
        indicator.stopAnimating()
        view.fadeOut()
        
        willMove(toParentViewController: nil)
        view.removeFromSuperview()
        removeFromParentViewController()
    }
}
