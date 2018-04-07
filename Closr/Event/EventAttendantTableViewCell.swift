//
//  EventAttendantTableViewCell.swift
//  Closr
//
//  Created by ZHITAO TIAN on 2017-08-01.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit
import EasyPeasy
import SwaggerClient

protocol EventAttendantTableViewCellDataSource: class {
    func eventAttendantHost() -> Profile
    func eventAttendantGuests() -> [Profile]
    func capability() -> Int
}

class EventAttendantTableViewCell: UITableViewCell, Reusable {

    weak var dataSource: EventAttendantTableViewCellDataSource?
    
    fileprivate lazy var collectionView: UICollectionView = {
        let layout                      = UICollectionViewFlowLayout()
        layout.scrollDirection          = .horizontal
        layout.itemSize                 = EventAttendantCollectionViewCell.preferredSize
        layout.minimumInteritemSpacing  = AppSizeMetric.breathPadding
        
        let collectionView                              = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource                       = self
        collectionView.delegate                         = self
        collectionView.showsHorizontalScrollIndicator   = false
        collectionView.backgroundColor                  = .white
        
        collectionView.register(EventAttendantCollectionViewCell.self, forCellWithReuseIdentifier: EventAttendantCollectionViewCell.reuseIdentifier)
        
        return collectionView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(collectionView)
        
        collectionView.easy.layout(
            Top(AppSizeMetric.defaultPadding),
            Leading(AppSizeMetric.breathPadding),
            Trailing(AppSizeMetric.breathPadding),
            Bottom(AppSizeMetric.defaultPadding),
            Height(EventAttendantCollectionViewCell.preferredSize.height)
        )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func load() {
        collectionView.reloadData()
    }
}


extension EventAttendantTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource?.capability() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventAttendantCollectionViewCell.reuseIdentifier, for: indexPath) as! EventAttendantCollectionViewCell
        
        switch indexPath.item {
        case 0:
            let host = dataSource?.eventAttendantHost()
            cell.update(with: host?.avatar, name: host?.displayName, isHost: true)
        default:
            let guests = dataSource?.eventAttendantGuests() ?? []
            
            if guests.count >= indexPath.item {
                let guest = guests[indexPath.item - 1]
                cell.update(with: guest.avatar, name: guest.displayName, isHost: false)
            } else {
                cell.update()
            }
        }
        
        return cell
    }
}
