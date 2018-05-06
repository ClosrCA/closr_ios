//
//  PromotionCarouselController.swift
//  Closr
//
//  Created by Tao on 2017-02-17.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit
import EasyPeasy
import CoreLocation

protocol PromotionCarouselControllerDelegate: class {
    func didFinishLoading(_ controller: PromotionCarouselController, coordinates: [CLLocationCoordinate2D])
    func didScrollTo(item: Int)
}

class PromotionCarouselController: UIViewController {

    fileprivate struct Constants {
        static let cardHorizontalSpacing: CGFloat = (Device.screenWidth - PromotionCollectionViewCell.preferredSize.width)/2
    }
    
    weak var delegate: PromotionCarouselControllerDelegate?
    
    fileprivate lazy var collectionView: UICollectionView = {
        
        let layout                      = UICollectionViewFlowLayout()
        layout.minimumLineSpacing       = Constants.cardHorizontalSpacing * 2
        layout.scrollDirection          = .horizontal
        layout.itemSize                 = PromotionCollectionViewCell.preferredSize
        
        let collectionView                                          = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource                                   = self
        collectionView.delegate                                     = self
        collectionView.showsHorizontalScrollIndicator               = false
        collectionView.isPagingEnabled                              = true
        collectionView.backgroundColor                              = .white
        
        collectionView.register(PromotionCollectionViewCell.self, forCellWithReuseIdentifier: PromotionCollectionViewCell.reuseIdentifier)
        
        return collectionView
    }()
    
    fileprivate lazy var pageControl: UIPageControl = {
        let pageControl                                         = UIPageControl()
        pageControl.hidesForSinglePage                          = true
        pageControl.currentPageIndicatorTintColor               = AppColor.brand
        pageControl.pageIndicatorTintColor                      = AppColor.background_gray
        
        return pageControl
    }()
    
    fileprivate var placeSearch: YelpPlaceSearch!
    
    fileprivate var promotions = [Promotion]() {
        didSet {
            pageControl.numberOfPages = promotions.count
            collectionView.reloadData()
            
            let coordinates = promotions.flatMap { $0.coordinate }
            delegate?.didFinishLoading(self, coordinates: coordinates)
        }
    }
    
    func scrollTo(item: Int) {
        collectionView.scrollToItem(at: IndexPath(item: item, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        
        createConstraints()
        
        reloadData()
    }

    fileprivate func createConstraints() {
        collectionView.easy.layout(Edges())
        
        pageControl.easy.layout(
            Bottom(),
            Leading(),
            Trailing(),
            Height(40)
        )
    }
    
    fileprivate func makeFilterButton(title: String) -> UIButton {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: floor(view.frame.width / 2), height: 30))
        button.setTitle(title, for: .normal)
        button.setTitleColor(AppColor.brand, for: .normal)
        button.setTitleColor(AppColor.secondary, for: .highlighted)
        button.titleLabel?.font = AppFont.title
        
        return button
    }
    
    fileprivate func reloadData() {
        
        Location.getCurrentLocation { [weak self] (location, error) in
            guard let weakSelf = self else {
                return
            }
            
            guard error == nil else {
                // TODO: location error popup
                return
            }
            
            weakSelf.placeSearch  = YelpPlaceSearch.foodSearch(with: location)
            
            weakSelf.placeSearch.fetchPlaces { (places, error) in
                if let places = places, error == nil {
                    
                    weakSelf.promotions = places.map { Promotion(resturantID: $0.placeID, resturantName: $0.name, address: $0.address?.displayAddress?.first, distance: $0.distance?.readableDescription, imageURL: $0.imageURL, startDate: nil, endDate: nil, duration: "M-F, 10am - 10pm", discount: "30%", price: nil, currency: nil, quantity: nil, item: nil, coordinate: $0.coordinates) }
                }
            }
        }
    }
}

extension PromotionCarouselController: UICollectionViewDataSource {
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

extension PromotionCarouselController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: AppSizeMetric.defaultPadding, left: Constants.cardHorizontalSpacing, bottom: AppSizeMetric.defaultPadding, right: Constants.cardHorizontalSpacing)
    }
}

extension PromotionCarouselController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailController    = RestaurantDetailViewController(placeID: promotions[indexPath.item].resturantID)
        detailController.search = placeSearch
        
        navigationController?.pushViewController(detailController, animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        let width = Device.screenWidth
        
        let currentPage = Int(offsetX / width)
        if currentPage != pageControl.currentPage {
            delegate?.didScrollTo(item: currentPage)
            pageControl.currentPage = currentPage
        }
    }
}

