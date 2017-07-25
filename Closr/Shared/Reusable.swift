//
//  Reusable.swift
//  Closr
//
//  Created by Tao on 2017-02-16.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit

protocol Reusable {
    
    static var reuseIdentifier: String { get }
}

extension Reusable {
    
    static var reuseIdentifier: String {
        
        return String(describing: self)
    }
}
