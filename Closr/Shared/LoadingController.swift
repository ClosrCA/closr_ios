//
//  LoadingController.swift
//  Closr
//
//  Created by ZHITAO TIAN on 2017-12-15.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit
import EasyPeasy

class LoadingController: UIViewController {

    fileprivate static let shared: LoadingController = LoadingController()
    
    static func startLoadingOn(_ viewController: UIViewController) {
        viewController.addChildViewController(shared)
        shared.view.frame = viewController.view.bounds
        viewController.view.addSubview(shared.view)
        shared.didMove(toParentViewController: viewController)
        
        shared.startAnimation()
    }
    
    static func stopLoading() {
        shared.teardown()
    }
    
    fileprivate lazy var indicator: UIActivityIndicatorView = {
        let indicator           = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        
        return indicator
    }()
    
    fileprivate lazy var indicatorBackground: UIView = {
        let view                    = UIView()
        view.backgroundColor        = .black
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
            Height(120),
            Leading(50),
            Trailing(50)
        ]
    }
    
    fileprivate func startAnimation() {
        view.alpha = 0.9
        indicator.fadeIn()
        indicator.startAnimating()
    }
    
    fileprivate func teardown() {
        indicator.stopAnimating()
        view.fadeOut {
            self.willMove(toParentViewController: nil)
            self.view.removeFromSuperview()
            self.removeFromParentViewController()
        }
    }
}
