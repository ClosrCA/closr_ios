//
//  RestaurantDetailImageCell.swift
//  Closr
//
//  Created by Tao on 2017-02-22.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit
import EasyPeasy

protocol RestaurantDetailImageCellDataSource: class {
    func imageURLStringFor(cell: RestaurantDetailImageCell) -> [String]
}

class RestaurantDetailImageCell: UITableViewCell, Reusable {

    weak var dataSource: RestaurantDetailImageCellDataSource?
    
    func loadImages() {
        collectionView.reloadData()
        pageControl.numberOfPages = dataSource?.imageURLStringFor(cell: self).count ?? 0
    }
    
    fileprivate lazy var collectionView: UICollectionView = {
        let layout                      = UICollectionViewFlowLayout()
        layout.minimumLineSpacing       = 0
        layout.minimumInteritemSpacing  = 0
        layout.scrollDirection          = .horizontal
        layout.itemSize                 = CGSize(width: Device.screenWidth, height: RestaurantDetailConstant.heroImageHeight)
        
        let collectionView                                          = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource                                   = self
        collectionView.delegate                                     = self
        collectionView.showsHorizontalScrollIndicator               = false
        collectionView.isPagingEnabled                              = true
        
        collectionView.register(ImageCarouselCell.self, forCellWithReuseIdentifier: ImageCarouselCell.reuseIdentifier)
        
        return collectionView
    }()

    fileprivate lazy var pageControl: UIPageControl = {
        let pageControl                                         = UIPageControl()
        pageControl.hidesForSinglePage                          = true
        pageControl.currentPageIndicatorTintColor               = RestaurantColor.primary
        pageControl.pageIndicatorTintColor                      = RestaurantColor.secondary
        
        return pageControl
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(collectionView)
        contentView.addSubview(pageControl)
        
        createConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func createConstraints() {
        collectionView <- [
            Edges(),
            Height(RestaurantDetailConstant.heroImageHeight)
        ]
        
        pageControl <- [
            Bottom(),
            Leading(),
            Trailing(),
            Height(40)
        ]
    }
}

extension RestaurantDetailImageCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource?.imageURLStringFor(cell: self).count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCarouselCell.reuseIdentifier, for: indexPath) as! ImageCarouselCell
        
        if let image = dataSource?.imageURLStringFor(cell: self)[indexPath.item] {
            cell.update(imageURLString: image)
        }
        
        return cell
    }
}

extension RestaurantDetailImageCell: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        let width = Device.screenWidth
        
        pageControl.currentPage = Int(offsetX / width)
    }
}

