//
//  ImageCarouselCell.swift
//  Closr
//
//  Created by Tao on 2017-02-22.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit
import EasyPeasy

class ImageCarouselCell: UICollectionViewCell, Reusable {
    
    fileprivate lazy var imageView: UIImageView = {
        let imageView               = UIImageView()
        imageView.backgroundColor   = UIColor.lightGray
        
        return imageView
    }()
    
    func update(imageURLString: String) {
        imageView.loadImage(URLString: imageURLString, placeholder: nil)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        
        imageView <- Edges()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.af_cancelImageRequest()
        
        imageView.image = nil
    }
}
