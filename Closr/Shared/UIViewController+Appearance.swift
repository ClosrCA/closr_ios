//
//  UIViewController+Appearance.swift
//  Closr
//
//  Created by ZHITAO TIAN on 2017-06-20.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func transparentNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage     = UIImage()
        navigationController?.navigationBar.isTranslucent   = true
    }
    
    func defaultNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UINavigationBar.appearance().backgroundImage(for: .default), for: .default)
        navigationController?.navigationBar.shadowImage     = UINavigationBar.appearance().shadowImage
        navigationController?.navigationBar.isTranslucent   = UINavigationBar.appearance().isTranslucent
    }
    
    class func setupGlobalAppearance() {
        let navBarAppearance            = UINavigationBar.appearance()
        navBarAppearance.barTintColor   = UIColor.white
        navBarAppearance.tintColor      = AppColor.brand
        navBarAppearance.isTranslucent  = false
        navBarAppearance.shadowImage    = UIImage.imageWith(color: AppColor.border, within: CGSize(width: 1, height: 1))
        navBarAppearance.setBackgroundImage(UIImage(), for: .default)
        
        let tabBarAppearance = UITabBar.appearance()
        tabBarAppearance.barTintColor   = UIColor.white
        tabBarAppearance.tintColor      = AppColor.brand
        tabBarAppearance.isTranslucent  = false
        tabBarAppearance.shadowImage    = UIImage()
        tabBarAppearance.backgroundImage = UIImage()
    }
}
