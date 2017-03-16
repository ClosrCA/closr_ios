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
        promotionController.tabBarItem = UITabBarItem(title: "promotion", image: UIImage(named: "promotion"), selectedImage: UIImage(named: "promotion_ative"))
        
        let resturantController = UINavigationController(rootViewController: RestaurantListViewController())
        resturantController.tabBarItem = UITabBarItem(title: "restaurant", image: UIImage(named: "restaurant"), selectedImage: UIImage(named: "restaurant_active"))
        
        let eventController = UINavigationController(rootViewController: UIViewController())
        eventController.tabBarItem = UITabBarItem(title: "event", image: UIImage(named: "event"), selectedImage: UIImage(named: "event_active"))
        
        let profileController = UINavigationController(rootViewController: ProfileViewController())
        profileController.tabBarItem = UITabBarItem(title: "profile", image: UIImage(named: "profile"), selectedImage: UIImage(named: "profile_active"))
        
        viewControllers = [promotionController, resturantController, eventController, profileController]
    }

}
