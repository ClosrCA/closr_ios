//
//  TabBarController.swift
//  Closr
//
//  Created by Tao on 2017-02-17.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = UIColor.brandColor
        
        let promotionController = UINavigationController(rootViewController: PromotionListViewController())
        promotionController.tabBarItem = UITabBarItem(title: "Promotion", image: nil, selectedImage: nil)
        
        let resturantController = UINavigationController(rootViewController: RestaurantListViewController())
        resturantController.tabBarItem = UITabBarItem(title: "Restaurant", image: nil, selectedImage: nil)
        
        let eventController = UINavigationController(rootViewController: UIViewController())
        eventController.tabBarItem = UITabBarItem(title: "Event", image: nil, selectedImage: nil)
        
        let profileController = UINavigationController(rootViewController: ProfileViewController())
        profileController.tabBarItem = UITabBarItem(title: "Profile", image: nil, selectedImage: nil)
        
        viewControllers = [promotionController, resturantController, eventController, profileController]
    }

}
