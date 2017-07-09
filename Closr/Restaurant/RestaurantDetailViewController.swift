//
//  RestaurantDetailViewController.swift
//  Closr
//
//  Created by Tao on 2017-02-22.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit
import EasyPeasy

class RestaurantDetailViewController: UIViewController {

    struct Constants {
        static let segmentedControlHeight: CGFloat              = 28
        static let segmentedControlHorizontalOffset: CGFloat    = -5
        
        static let childControllerViewVerticalPadding: CGFloat      = 15
        static let childControllerViewHorizontalPadding: CGFloat    = 10
    }
    
    var search: YelpPlaceSearch?
    
    fileprivate var placeID: String
    
    fileprivate var restaurant: YelpPlace? {
        didSet {
            loadData()
        }
    }
    
    fileprivate lazy var carouselViewController: ImageCarouselViewController = {
        let controller      = ImageCarouselViewController()
        controller.delegate = self
        
        return controller
    }()
    
    fileprivate lazy var segmentedControl: UISegmentedControl = {
        let control                     = UISegmentedControl(items: ["Details", "Events"])
        control.tintColor               = AppColor.brand
        control.selectedSegmentIndex    = 0
        
        control.addTarget(self, action: #selector(onSegmentedControl(sender:)), for: .valueChanged)
        
        return control
    }()
    
    fileprivate lazy var detailTableViewController: DetailTableViewController = {
        let controller          = DetailTableViewController()
        controller.dataSource   = self
        
        return controller
    }()
    
    fileprivate lazy var createEventButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create Event", for: .normal)
        button.setTitleColor(AppColor.lightButtonTitle, for: .normal)
        button.setBackgroundImage(UIImage.imageWith(color: AppColor.brand, within: CGSize(width: 1, height: 1)), for: .normal)
        button.addTarget(self, action: #selector(onCreateEvent), for: .touchUpInside)
        
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        
        return button
    }()
    
    init(placeID: String) {
        
        self.placeID = placeID
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        buildUI()
        
        createConstraints()
        
        // TODO: Loading indicator
        
        search?.fetch(placeID: placeID, completion: { [weak self] (place, error) in
            if error == nil {
                self?.restaurant = place
            }
        })
    }
    
    fileprivate func loadData() {
        carouselViewController.loadImages()
        detailTableViewController.reload()
    }
    
    fileprivate func buildUI() {
        addChildViewController(carouselViewController)
        view.addSubview(carouselViewController.view)
        carouselViewController.didMove(toParentViewController: self)
        
        view.addSubview(segmentedControl)
        
        addChildViewController(detailTableViewController)
        view.addSubview(detailTableViewController.view)
        detailTableViewController.didMove(toParentViewController: self)
    }
    
    fileprivate func createConstraints() {
        carouselViewController.view <- [
            Top(),
            Leading(),
            Trailing(),
            Height(ImageCarouselViewController.preferredHeight)
        ]
        
        segmentedControl <- [
            Top().to(carouselViewController.view),
            Leading(Constants.segmentedControlHorizontalOffset),
            Trailing(Constants.segmentedControlHorizontalOffset),
            Height(Constants.segmentedControlHeight)
        ]
        
        detailTableViewController.view <- [
            Top(Constants.childControllerViewVerticalPadding).to(segmentedControl),
            Leading(Constants.childControllerViewHorizontalPadding),
            Trailing(Constants.childControllerViewHorizontalPadding),
            Bottom(Constants.childControllerViewVerticalPadding)
        ]
    }
    
    @objc
    fileprivate func onSegmentedControl(sender: UISegmentedControl) {
        
    }
    
    @objc
    fileprivate func onCreateEvent() {
        
        let createEventController = CreateEventViewController()
        createEventController.place = restaurant
        
        present(UINavigationController(rootViewController: createEventController), animated: true)
    }
}


extension RestaurantDetailViewController: ImageCarouselViewControllerDelegate {
    func imageURLStringFor(controller: ImageCarouselViewController) -> [String] {
        
        return restaurant?.photos ?? []
    }
}

extension RestaurantDetailViewController: DetailTableViewControllerDataSource {
    func restaurantOfDetail(controller: DetailTableViewController) -> YelpPlace? {
        return restaurant
    }
}
