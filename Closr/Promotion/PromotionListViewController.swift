//
//  PromotionListViewController.swift
//  Closr
//
//  Created by Tao on 2017-02-17.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit
import EasyPeasy

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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        buildNavigationItems()
        
        view.addSubview(collectionView)
        
        createConstraints()
        
        collectionView.reloadData()
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
        button.titleLabel?.font = PromotionFont.navigationFilter
        
        return button
    }
}

extension PromotionListViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PromotionCollectionViewCell.reuseIdentifier, for: indexPath) as! PromotionCollectionViewCell
        
        return cell
    }
}

extension PromotionListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 2 * PromotionListConstant.collectionViewPadding - PromotionListConstant.minItemSpace) / 2
        let height = width * PromotionListConstant.Cell.imageAspectRatio
        
        return CGSize(width: width, height: height)
    }
}

extension PromotionListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
