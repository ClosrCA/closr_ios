//
//  UILabel+Make.swift
//  Closr
//
//  Created by Tao on 2017-03-09.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit

extension UILabel {
    class func makeLabel(font: UIFont, textColor: UIColor, text: String? = nil, numberOfLines: Int = 1, alignment: NSTextAlignment = .center) -> UILabel {
        let label               = UILabel()
        label.font              = font
        label.textColor         = textColor
        label.text              = text
        label.textAlignment     = alignment
        label.numberOfLines     = numberOfLines
        
        return label
    }
}
