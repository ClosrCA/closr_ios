//
//  RootViewController.swift
//  Closr
//
//  Created by Tao on 2017-01-25.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit
import CoreLocation

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Place.placeNearby(location: CLLocationCoordinate2D.downtownToronto, type: .restaurant) { (places, error) in
            places?.forEach { print($0.description) }
        }
    }

}

