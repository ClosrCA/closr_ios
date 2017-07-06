//
//  ImageCarouselViewController.swift
//  Closr
//
//  Created by Tao on 2017-02-22.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit
import EasyPeasy

protocol ImageCarouselViewControllerDelegate {
    func imageURLStringFor(controller: ImageCarouselViewController) -> [String]
}

class ImageCarouselViewController: UIViewController {

    static let preferredHeight: CGFloat = 176
    
    var delegate: ImageCarouselViewControllerDelegate?
    
    func loadImages() {
        collectionView.reloadData()
        pageControl.numberOfPages = delegate?.imageURLStringFor(controller: self).count ?? 0
    }
    
    fileprivate lazy var collectionView: UICollectionView = {
        let layout                      = UICollectionViewFlowLayout()
        layout.minimumLineSpacing       = 0
        layout.minimumInteritemSpacing  = 0
        layout.scrollDirection          = .horizontal
        layout.itemSize                 = CGSize(width: Device.screenWidth, height: ImageCarouselViewController.preferredHeight)
        
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
        pageControl.currentPageIndicatorTintColor               = AppColor.brand
        
        return pageControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        
        collectionView <- Edges()
        
        pageControl <- [
            Bottom(),
            Leading(),
            Trailing(),
            Height(40)
        ]
    }
}

extension ImageCarouselViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return delegate?.imageURLStringFor(controller: self).count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCarouselCell.reuseIdentifier, for: indexPath) as! ImageCarouselCell
        
        if let image = delegate?.imageURLStringFor(controller: self)[indexPath.item] {
            cell.update(imageURLString: image)
        }
        
        return cell
    }
}

extension ImageCarouselViewController: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        let width = Device.screenWidth
        
        pageControl.currentPage = Int(offsetX / width)
    }
}

