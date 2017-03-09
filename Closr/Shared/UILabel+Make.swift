//
//  UILabel+Make.swift
//  Closr
//
//  Created by Tao on 2017-03-09.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit

extension UILabel {
    class func makeLable(font: UIFont, textColor: UIColor, text: String? = nil, alignment: NSTextAlignment = .center) -> UILabel {
        let label               = UILabel()
        label.font              = font
        label.textColor         = textColor
        label.text              = text
        label.textAlignment     = alignment
        
        return label
    }
}
