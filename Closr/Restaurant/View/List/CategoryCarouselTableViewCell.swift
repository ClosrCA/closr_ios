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
    case burger
    case steak
    case pizza
    
    case count
    
    var image: UIImage? {
        switch self {
        case .burger:
            return UIImage(named: "burgers")
        case .steak:
            return UIImage(named: "steak")
        case .pizza:
            return UIImage(named: "pizza")
        default:
            return nil
        }
    }
    
    var title: String {
        switch self {
        case .burger:
            return "BURGERS"
        case .steak:
            return "STEAKHOUSE"
        case .pizza:
            return "PIZZA"
        default:
            return ""
        }
    }
}

class CategoryCarouselTableViewCell: UITableViewCell, Reusable {

    fileprivate lazy var collectionView: UICollectionView = {
        let layout                      = UICollectionViewFlowLayout()
        layout.scrollDirection          = .horizontal
        layout.itemSize                 = RestaurantListConstant.Category.cellSize
        layout.minimumInteritemSpacing  = RestaurantListConstant.Category.lineSpace
        
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
        
        let cellHeight = RestaurantListConstant.Category.cellSize.height + 2*RestaurantListConstant.Category.lineSpace
        
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
        return CategoryItem.count.rawValue
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.reuseIdentifier, for: indexPath) as! CategoryCollectionViewCell
        
        if let item = CategoryItem(rawValue: indexPath.item) {
            cell.update(with: item)
        }
        
        return cell
    }
}
