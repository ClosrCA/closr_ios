//
//  EventCollectionTableViewCell.swift
//  Closr
//
//  Created by ZHITAO TIAN on 2017-03-26.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit
import EasyPeasy

class EventCollectionTableViewCell: UITableViewCell, Reusable {

    var isCurrent: Bool = true {
        didSet {
            collectionView.backgroundColor = isCurrent ? AppColor.brandBackground : UIColor.white
        }
    }
    
    fileprivate lazy var collectionView: UICollectionView = {
        let layout                      = UICollectionViewFlowLayout()
        layout.scrollDirection          = .horizontal
        layout.itemSize                 = EventCollectionViewCell.preferredSize
        layout.minimumLineSpacing       = 0
        layout.minimumInteritemSpacing  = 0
        
        let collectionView                              = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource                       = self
        collectionView.delegate                         = self
        collectionView.backgroundColor                  = AppColor.brandBackground
        collectionView.showsHorizontalScrollIndicator   = false
        
        collectionView.register(EventCollectionViewCell.self, forCellWithReuseIdentifier: EventCollectionViewCell.reuseIdentifier)
        
        return collectionView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(collectionView)
        
        collectionView <- [
            Edges(),
            Height(EventCollectionViewCell.preferredSize.height)
        ]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EventCollectionTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventCollectionViewCell.reuseIdentifier, for: indexPath) as! EventCollectionViewCell
        
        cell.update(title: "Restaurant Name \(indexPath.item)", date: Date(), avatars: nil, isCurrent: isCurrent)
        
        return cell
    }
}
