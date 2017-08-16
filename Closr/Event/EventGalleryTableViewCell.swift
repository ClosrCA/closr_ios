//
//  EventGalleryTableViewCell.swift
//  Closr
//
//  Created by ZHITAO TIAN on 2017-08-15.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit
import EasyPeasy

protocol EventGalleryTableViewCellDataSource: class {
    func imageURLs(in cell: EventGalleryTableViewCell) -> [String]
}

class EventGalleryTableViewCell: UITableViewCell, Reusable {

    fileprivate struct Constant {
        static let imageSize: CGSize        = CGSize(width: 111, height: 70)
        static let galleryHeight: CGFloat   = 86
    }
    
    weak var dataSource: EventGalleryTableViewCellDataSource?
    
    lazy var collectionView: UICollectionView = {
        let layout                      = UICollectionViewFlowLayout()
        layout.minimumLineSpacing       = AppSizeMetric.breathPadding
        layout.minimumInteritemSpacing  = 0
        layout.scrollDirection          = .horizontal
        layout.itemSize                 = Constant.imageSize
        
        let collectionView                                          = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource                                   = self
        collectionView.showsHorizontalScrollIndicator               = false
        collectionView.backgroundColor                              = .white
        
        collectionView.register(ImageCarouselCell.self, forCellWithReuseIdentifier: ImageCarouselCell.reuseIdentifier)
        
        return collectionView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(collectionView)
        
        collectionView <- [
            Top(AppSizeMetric.defaultPadding),
            Leading(AppSizeMetric.breathPadding),
            Trailing(AppSizeMetric.breathPadding),
            Bottom(AppSizeMetric.defaultPadding),
            Height(Constant.galleryHeight)
        ]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadImages() {
        collectionView.reloadData()
    }
}

extension EventGalleryTableViewCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource?.imageURLs(in: self).count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCarouselCell.reuseIdentifier, for: indexPath) as! ImageCarouselCell
        
        if let image = dataSource?.imageURLs(in: self)[indexPath.item] {
            cell.update(imageURLString: image)
        }
        
        return cell
    }
}
