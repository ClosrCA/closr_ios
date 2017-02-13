//
//  Image+Editing.swift
//  Closr
//
//  Created by Tao on 2017-02-12.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit

extension UIImage {
    
    func imageWithOverlay(color: UIColor) -> UIImage? {
        
        defer {
            UIGraphicsEndImageContext()
        }
        
        let rect = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        
        draw(in: rect)
        
        let context = UIGraphicsGetCurrentContext()
        context?.setBlendMode(.sourceIn)
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    class func imageWith(color: UIColor, within size: CGSize) -> UIImage? {
        
        defer {
            UIGraphicsEndImageContext()
        }
        
        let rect = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
