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
    
    func loadImage(withPhoto photo: GooglePhoto, placeholder: UIImage?, maxSize: CGSize) {
        
        self.image = placeholder
        
        guard let reference = photo.reference else {
            return
        }
        
        let imageCache = UIImageView.af_sharedImageDownloader.imageCache
        
        if let cachedImage = imageCache?.image(withIdentifier: reference) {
            
            self.image = cachedImage
            
            return
        }
        
        let params = GoogleAPI.authenticate(params: ["photoreference": reference,
                                                     "maxwidth": maxSize.width])
        
        
        Alamofire.request(GoogleAPI.PlaceURL.photo, parameters: params).responseImage { [weak self] (response) in
            
            switch response.result {
            case .success(let value):
                self?.image = value
                imageCache?.add(value, withIdentifier: reference)
            case .failure(_):
                return
            }
        }
    }
    
    func loadImage(URLString: String, placeholder: UIImage?) {
        
        self.image = placeholder
        
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
