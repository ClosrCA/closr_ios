//
//  EventThumbnailFactory.swift
//  Closr
//
//  Created by ZHITAO TIAN on 2017-03-27.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit
import EasyPeasy

class EventThumbnailFactory {
    
    fileprivate static let sizeAspectRatio: CGFloat = 0.48
    
    static func thumbnail(images: [String], required: Int) -> UIView {
        
        let placeholder = UIImage.imageWith(color: AppColor.text_light_gray, within: CGSize(width: 1, height: 1))
        
        func makeBackground() -> UIView {
            let view = UIView()
            view.backgroundColor = UIColor.white
            
            return view
        }
        
        func imageView(from imageURL: String?) -> UIImageView {
            let imageView = UIImageView()
            
            imageView.loadImage(URLString: imageURL, placeholder: placeholder)
            
            return imageView
        }
        
        switch required {
        case 0:
            return UIView()
        case 1:
            return imageView(from: images.first)
        case 2:
            let backgroundView = makeBackground()
            
            let leftImageView = imageView(from: images.first)
            
            let rightImageView = imageView(from: images.last)
            
            backgroundView.addSubview(leftImageView)
            backgroundView.addSubview(rightImageView)
            
            leftImageView <- [
                Leading(),
                Top(),
                Bottom(),
                Width(*sizeAspectRatio).like(backgroundView)
            ]
            
            rightImageView <- [
                Trailing(),
                Top(),
                Bottom(),
                Width(*sizeAspectRatio).like(backgroundView)
            ]
            
            return backgroundView
        case 3:
            let backgroundView = makeBackground()
            
            var mutableImages = images
            
            let topLeftImaggeView = imageView(from: mutableImages.popLast())
            
            let bottomLeftImageView = imageView(from: mutableImages.popLast())
            
            let rightImageView = imageView(from: mutableImages.popLast())
            
            backgroundView.addSubview(topLeftImaggeView)
            backgroundView.addSubview(bottomLeftImageView)
            backgroundView.addSubview(rightImageView)
            
            topLeftImaggeView <- [
                Leading(),
                Top(),
                Height(*sizeAspectRatio).like(backgroundView),
                Width(*sizeAspectRatio).like(backgroundView)
            ]
            
            bottomLeftImageView <- [
                Leading(),
                Bottom(),
                Height(*sizeAspectRatio).like(backgroundView),
                Width(*sizeAspectRatio).like(backgroundView)
            ]
            
            rightImageView <- [
                Trailing(),
                Top(),
                Bottom(),
                Width(*sizeAspectRatio).like(backgroundView)
            ]
            
            return backgroundView
        default:
            let backgroundView = makeBackground()
            
            var mutableImages = images
            
            let topLeftImaggeView = imageView(from: mutableImages.popLast())
            
            let bottomLeftImageView = imageView(from: mutableImages.popLast())
            
            let topRightImageView = imageView(from: mutableImages.popLast())
            
            let bottomRightImageView = imageView(from: mutableImages.popLast())
            
            backgroundView.addSubview(topLeftImaggeView)
            backgroundView.addSubview(bottomLeftImageView)
            backgroundView.addSubview(topRightImageView)
            backgroundView.addSubview(bottomRightImageView)
            
            topLeftImaggeView <- [
                Leading(),
                Top(),
                Height(*sizeAspectRatio).like(backgroundView),
                Width(*sizeAspectRatio).like(backgroundView)
            ]
            
            bottomLeftImageView <- [
                Leading(),
                Bottom(),
                Height(*sizeAspectRatio).like(backgroundView),
                Width(*sizeAspectRatio).like(backgroundView)
            ]
            
            topRightImageView <- [
                Trailing(),
                Top(),
                Height(*sizeAspectRatio).like(backgroundView),
                Width(*sizeAspectRatio).like(backgroundView)
            ]
            
            bottomRightImageView <- [
                Trailing(),
                Bottom(),
                Height(*sizeAspectRatio).like(backgroundView),
                Width(*sizeAspectRatio).like(backgroundView)
            ]
            
            return backgroundView
        }
    }
}
