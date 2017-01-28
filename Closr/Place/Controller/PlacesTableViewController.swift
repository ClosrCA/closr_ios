//
//  PlacesTableViewController.swift
//  Closr
//
//  Created by Tao on 2017-01-27.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit
import CoreLocation

class PlacesTableViewController: UITableViewController {

    var placeFactory = PlaceSearch()
    
    var places = [Place]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension

        placeFactory.placeNearby(location: CLLocationCoordinate2D.downtownToronto, type: .restaurant) { (places, error) in
            if error == nil {
                
                if let places = places {
                    self.places = places
                }
                
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeFactory.places.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "placeCell", for: indexPath) as! PlaceTableViewCell

        let place = places[indexPath.row]
        
        cell.nameLabel.text = place.name
        cell.addressLabel.text = place.address
        
        if let photo = place.photos?.first {
            cell.previewImageView.loadImage(withPhoto: photo, placeholder: nil, maxSize: CGSize(width: 100, height: 100))
        }

        return cell
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let height = scrollView.frame.height
        let distanceFromBottom = scrollView.contentSize.height - scrollView.contentOffset.y
        
        if distanceFromBottom <= height {
            
            placeFactory.nextPage(completion: { (places, error) in
                if let places = places {
                    self.places = places
                }
            })
        }
    }

}
