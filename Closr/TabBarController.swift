//
//  TabBarController.swift
//  Closr
//
//  Created by Tao on 2017-02-17.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    enum Tabs: Int {
        case promotion  = 1
        case restaurant = 2
        case event      = 3
        case profile    = 4
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = AppColor.brand
        
        let promotionController = UINavigationController(rootViewController: PromotionListViewController())
        promotionController.tabBarItem = UITabBarItem(title: "Promotions", image: UIImage(named: "promotion"), tag: Tabs.promotion.rawValue)
        
        let resturantController = UINavigationController(rootViewController: RestaurantListViewController())
        resturantController.tabBarItem = UITabBarItem(title: "Restaurants", image: UIImage(named: "restaurant"), tag: Tabs.restaurant.rawValue)
        
        let eventController = UINavigationController(rootViewController: JoinEventListViewController())
        eventController.tabBarItem = UITabBarItem(title: "Events", image: UIImage(named: "event"), tag: Tabs.event.rawValue)
        
        let profileController = UINavigationController(rootViewController: ProfileViewController())
        profileController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profile"), tag: Tabs.profile.rawValue)
        
        viewControllers = [promotionController, resturantController, eventController, profileController]
    }

}
