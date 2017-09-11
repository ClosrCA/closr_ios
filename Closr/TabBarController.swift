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
        
        let promotionController = UINavigationController(rootViewController: PromotionViewController())
        promotionController.tabBarItem = UITabBarItem(title: "Promotion", image: UIImage(named: "promotion"), tag: Tabs.promotion.rawValue)
        
        let resturantController = UINavigationController(rootViewController: RestaurantListViewController())
        resturantController.tabBarItem = UITabBarItem(title: "Restaurant", image: UIImage(named: "restaurant"), tag: Tabs.restaurant.rawValue)
        
        let eventController = UINavigationController(rootViewController: EventViewController())
        eventController.tabBarItem = UITabBarItem(title: "Event", image: UIImage(named: "event"), tag: Tabs.event.rawValue)
        
        
        let profileController           = MyProfileViewController()
        profileController.user          = User.current
        
        profileController.tabBarItem    = UITabBarItem(title: "Profile", image: UIImage(named: "profile"), tag: Tabs.profile.rawValue)
        
        viewControllers = [resturantController, promotionController, eventController, profileController]
    }

}
