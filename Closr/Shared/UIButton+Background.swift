//
//  UIButton+Background.swift
//  Closr
//
//  Created by ZHITAO TIAN on 2017-08-27.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit

extension UIButton {
    func setBackgroundColor(color: UIColor, for state: UIControlState) {
        setBackgroundImage(UIImage.imageWith(color: color, within: CGSize(width: 1, height: 1)), for: state)
    }
}
