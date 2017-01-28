//
//  Photo.swift
//  Closr
//
//  Created by Tao on 2017-01-27.
//  Copyright © 2017 closr. All rights reserved.
//

import Alamofire
import AlamofireImage
import ObjectMapper

class Photo: Mappable {
    var height: Double?
    var width: Double?
    var reference: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        height      <- map["height"]
        width       <- map["width"]
        reference   <- map["photo_reference"]
    }
}

typealias ImageHandler = ((UIImage?, Error?) -> Void)

extension UIImageView {
    
    func loadImage(withPhoto photo: Photo, placeholder: UIImage?, maxSize: CGSize) {
        
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
                                                     "maxwidth": maxSize.width,
                                                     "maxheight": maxSize.height])
        
        
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
}
