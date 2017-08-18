//
//  CategoryCarouselTableViewCell.swift
//  Closr
//
//  Created by ZHITAO TIAN on 2017-05-27.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit
import EasyPeasy

enum CategoryItem: Int {
    
    static let count = 4
    
    case cafe
    case burger
    case steak
    case buffet
    
    var image: UIImage? {
        switch self {
        case .cafe:
            return UIImage(named: "icon_category_cafe")
        case .burger:
            return UIImage(named: "icon_category_burger")
        case .steak:
            return UIImage(named: "icon_category_steak")
        case .buffet:
            return UIImage(named: "icon_category_buffet")
        }
    }
    
    var title: String {
        switch self {
        case .cafe:
            return "CAFE"
        case .burger:
            return "BURGERS"
        case .steak:
            return "STEAKHOUSE"
        case .buffet:
            return "BUFFET"
        }
    }
}

class CategoryCarouselTableViewCell: UITableViewCell, Reusable {

    fileprivate lazy var collectionView: UICollectionView = {
        let layout                      = UICollectionViewFlowLayout()
        layout.scrollDirection          = .horizontal
        layout.itemSize                 = CategoryCollectionViewCell.preferredCellSize
        layout.minimumInteritemSpacing  = CategoryCollectionViewCell.preferredLineSpace
        
        let collectionView                              = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource                       = self
        collectionView.delegate                         = self
        collectionView.backgroundColor                  = UIColor.white
        collectionView.showsHorizontalScrollIndicator   = false
        
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.reuseIdentifier)
        
        return collectionView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        contentView.addSubview(collectionView)
        
        let cellHeight = CategoryCollectionViewCell.preferredCellSize.height + 2*CategoryCollectionViewCell.preferredLineSpace
        
        collectionView <- [
            Edges(),
            Height(cellHeight)
        ]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CategoryCarouselTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CategoryItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.reuseIdentifier, for: indexPath) as! CategoryCollectionViewCell
        
        if let item = CategoryItem(rawValue: indexPath.item) {
            cell.update(with: item)
        }
        
        return cell
    }
}
