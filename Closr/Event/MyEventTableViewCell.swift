//
//  MyEventTableViewCell.swift
//  Closr
//
//  Created by Yale的Mac on 2017/7/5.
//  Copyright © 2017年 closr. All rights reserved.
//

import UIKit
import EasyPeasy

class MyEventTableViewCell: UITableViewCell, Reusable {
    
    
    fileprivate lazy var eventCollectionView: UICollectionView = {
        let layout                      = UICollectionViewFlowLayout()
        layout.scrollDirection          = .horizontal
        layout.itemSize                 = MyEventCollectionViewCell.preferredSize
        layout.minimumLineSpacing       = 0
        layout.minimumInteritemSpacing  = 0
        
        let eventCollectionView                              = UICollectionView(frame: .zero, collectionViewLayout: layout)
        eventCollectionView.dataSource                       = self
        eventCollectionView.delegate                         = self
        eventCollectionView.backgroundColor                  = .white
        eventCollectionView.showsHorizontalScrollIndicator   = false
        
        eventCollectionView.register(MyEventCollectionViewCell.self, forCellWithReuseIdentifier: MyEventCollectionViewCell.reuseIdentifier)
        
        return eventCollectionView
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(eventCollectionView)
        
        eventCollectionView.easy.layout(
            Edges(),
            Height(MyEventCollectionViewCell.preferredSize.height)
        )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension MyEventTableViewCell : UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyEventCollectionViewCell.reuseIdentifier, for: indexPath) as! MyEventCollectionViewCell
        
        cell.updateMockEvent(with: 2, capability: 4)
        return cell
    }
}
