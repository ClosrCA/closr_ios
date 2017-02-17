//
//  ImageLoader.swift
//  Closr
//
//  Created by Tao on 2017-01-31.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

extension UIImageView {
    
    func loadImage(URLString: String?, placeholder: UIImage?) {
        
        self.image = placeholder
        
        guard let URLString = URLString else {
            return
        }
        
        guard let URL = URL(string: URLString) else {
            return
        }
        
        let imageCache = UIImageView.af_sharedImageDownloader.imageCache
        
        if let cachedImage = imageCache?.image(withIdentifier: URLString) {
            
            self.image = cachedImage
            
            return
        }
        
        Alamofire.request(URL).responseImage { [weak self] (response) in
            
            switch response.result {
            case .success(let value):
                self?.image = value
                imageCache?.add(value, withIdentifier: URLString)
            case .failure(_):
                return
            }
        }
    }
}
