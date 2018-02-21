//
//  ChatHeaderViewController.swift
//  Closr
//
//  Created by ZHITAO TIAN on 2018-01-31.
//  Copyright © 2018 closr. All rights reserved.
//

import UIKit
import EasyPeasy

protocol ChatHeaderViewControllerDelegate: class {
    func chatHeaderAvatarImage() -> [String?]
    func chatterName() -> [String]
}

class ChatHeaderViewController: UIViewController {

    static let preferredHeight: CGFloat = 140
    
    weak var delegate: ChatHeaderViewControllerDelegate?
    
    lazy var collectionView: UICollectionView = {
        let layout                      = UICollectionViewFlowLayout()
        layout.scrollDirection          = .horizontal
        layout.itemSize                 = CGSize(width: 85, height: 140)
        layout.minimumInteritemSpacing  = AppSizeMetric.breathPadding
        
        let collectionView                              = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource                       = self
        collectionView.delegate                         = self
        collectionView.backgroundColor                  = UIColor.white
        collectionView.showsHorizontalScrollIndicator   = false
        
        collectionView.register(AvatarCell.self, forCellWithReuseIdentifier: AvatarCell.reuseIdentifier)
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        collectionView.easy.layout(Edges())
    }
}

extension ChatHeaderViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return delegate?.chatHeaderAvatarImage().count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AvatarCell.reuseIdentifier, for: indexPath) as! AvatarCell
        let imageString = delegate?.chatHeaderAvatarImage()[indexPath.item]
        let name = delegate?.chatterName()[indexPath.item]
        let isHost = indexPath.item == 0
        
        cell.update(imageString: imageString, name: name, host: isHost)
        
        return cell
    }
}

class AvatarCell: UICollectionViewCell, Reusable {
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = AppSizeMetric.avatarSize.height / 2
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    lazy var nameLabel: UILabel = UILabel.makeLabel(font: AppFont.text, textColor: AppColor.text_dark, alignment: .center)
    
    lazy var hostLabel: UILabel = UILabel.makeLabel(font: AppFont.text, textColor: AppColor.brand,  alignment: .center)
    
    func update(imageString: String?, name: String?, host: Bool = false) {
        imageView.loadImage(URLString: imageString, placeholder: UIImage(named: "icon_user"))
        nameLabel.text = name
        hostLabel.text = host ? "host" : ""
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(hostLabel)
        
        createConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createConstraints() {
        imageView.easy.layout(
            Center(),
            Size(AppSizeMetric.avatarSize))
        
        nameLabel.easy.layout(
            Leading(),
            Trailing(),
            Top(AppSizeMetric.defaultPadding).to(imageView))
        
        hostLabel.easy.layout(
            Leading(),
            Trailing(),
            Top(AppSizeMetric.defaultPadding).to(nameLabel))
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
        imageView.cancelLoading()
    }
    
}
