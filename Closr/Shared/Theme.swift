//
//  Theme.swift
//  Closr
//
//  Created by Tao on 2017-02-16.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit

extension UIColor {
    static let brandColor = UIColor(red: 233 / 255, green: 90 / 255, blue: 49 / 255, alpha: 1.0)
}

extension UIViewController {
    
    func transparentNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage     = UIImage()
    }
    
    func defaultNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UINavigationBar.appearance().backgroundImage(for: .default), for: .default)
        navigationController?.navigationBar.shadowImage     = UINavigationBar.appearance().shadowImage
    }
}
