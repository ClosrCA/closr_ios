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
    
    fileprivate lazy var eventListViewController: JoinEventListViewController = JoinEventListViewController()
    
    fileprivate lazy var createEventButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create Event", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setBackgroundColor(color: AppColor.brand, for: .normal)
        button.addTarget(self, action: #selector(onCreateEvent), for: .touchUpInside)
        
        return button
    }()
    
    init(placeID: String) {
        
        self.placeID = placeID
        
        super.init(nibName: nil, bundle: nil)
        
        hidesBottomBarWhenPushed = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        buildUI()
        
        createConstraints()
        
        LoadingController.startLoadingOn(self)
        
        search?.fetch(placeID: placeID, completion: { [weak self] (place, error) in
            
            LoadingController.stopLoading()
            
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
        
        view.addSubview(createEventButton)
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
        
        createEventButton <- [
            Height(AppSizeMetric.buttonHeight),
            Leading(),
            Trailing(),
            Bottom()
        ]
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        if eventListViewController.parent != nil {
            eventListViewController.view <- [
                Top(Constants.childControllerViewVerticalPadding).to(segmentedControl),
                Leading(Constants.childControllerViewHorizontalPadding),
                Trailing(Constants.childControllerViewHorizontalPadding),
                Bottom(Constants.childControllerViewVerticalPadding).to(createEventButton)
            ]
        }
        
        if detailTableViewController.parent != nil {
            detailTableViewController.view <- [
                Top(Constants.childControllerViewVerticalPadding).to(segmentedControl),
                Leading(Constants.childControllerViewHorizontalPadding),
                Trailing(Constants.childControllerViewHorizontalPadding),
                Bottom(Constants.childControllerViewVerticalPadding).to(createEventButton)
            ]
        }
    }
    
    @objc
    fileprivate func onSegmentedControl(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            cycleFrom(controller: eventListViewController, to: detailTableViewController)
        case 1:
            cycleFrom(controller: detailTableViewController, to: eventListViewController)
        default:
            break
        }
        
        updateViewConstraints()
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
