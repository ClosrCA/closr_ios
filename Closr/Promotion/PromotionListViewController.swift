//
//  PromotionListViewController.swift
//  Closr
//
//  Created by Tao on 2017-02-17.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit
import EasyPeasy
import CoreLocation

class PromotionListViewController: UIViewController {

    fileprivate lazy var collectionView: UICollectionView = {
        
        let layout                          = UICollectionViewFlowLayout()
        layout.minimumLineSpacing           = PromotionListConstant.minItemSpace
        layout.minimumInteritemSpacing      = PromotionListConstant.minItemSpace
        
        let collectionView                                          = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints    = false
        collectionView.backgroundColor                              = UIColor.white
        collectionView.delegate                                     = self
        collectionView.dataSource                                   = self
        collectionView.contentInset                                 = UIEdgeInsets(top: PromotionListConstant.collectionViewPadding,
                                                                                   left: PromotionListConstant.collectionViewPadding,
                                                                                   bottom: PromotionListConstant.collectionViewPadding,
                                                                                   right: PromotionListConstant.collectionViewPadding)
        
        collectionView.register(PromotionCollectionViewCell.self, forCellWithReuseIdentifier: PromotionCollectionViewCell.reuseIdentifier)
        
        return collectionView
    }()
    
    fileprivate lazy var placeSearch: YelpPlaceSearch = {
        
        let searchRequest = PlaceSearchRequest(center: CLLocationCoordinate2D.downtownToronto, radius: CLLocationDistance.defaultRadius, type: YelpAPIConsole.PlaceType.food)
        
        return YelpPlaceSearch(searchRequest: searchRequest)
    }()
    
    fileprivate var promotions = [Promotion]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        buildNavigationItems()
        
        view.addSubview(collectionView)
        
        createConstraints()
        
        reloadData()
    }

    fileprivate func createConstraints() {
        collectionView <- Edges()
    }
    
    fileprivate func buildNavigationItems() {
        let loctionFilter = makeFilterButton(title: "Location ⌵")
        let cuisineFilter = makeFilterButton(title: "Cuisine ⌵")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: loctionFilter)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: cuisineFilter)
    }
    
    fileprivate func makeFilterButton(title: String) -> UIButton {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: floor(view.frame.width / 2), height: 30))
        button.setTitle(title, for: .normal)
        button.setTitleColor(PromotionColor.primary, for: .normal)
        button.setTitleColor(PromotionColor.secondary, for: .highlighted)
        button.titleLabel?.font = PromotionFont.navigationFilter
        
        return button
    }
    
    fileprivate func reloadData() {
        
        placeSearch.placeNearby { [unowned self] (places, error) in
            if let places = places, error == nil {
                
                self.promotions = places.map { Promotion(resturantID: $0.placeID, resturantName: $0.name, distance: $0.distance?.readableDescription, imageURL: $0.imageURL, startDate: nil, endDate: nil, discount: "30%", price: nil, currency: nil, quantity: nil, item: nil) }
            }
        }
    }
}

extension PromotionListViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return promotions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PromotionCollectionViewCell.reuseIdentifier, for: indexPath) as! PromotionCollectionViewCell
        
        cell.update(promotion: promotions[indexPath.item])
        
        return cell
    }
}

extension PromotionListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 2 * PromotionListConstant.collectionViewPadding - PromotionListConstant.minItemSpace) / 2
        
        return CGSize(width: width, height: PromotionListConstant.Cell.height)
    }
}

extension PromotionListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
