//
//  UIView+Animation.swift
//  Closr
//
//  Created by ZHITAO TIAN on 2017-06-20.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit

let cAnimationDuration = 0.2

extension UIView {
    
    func fadeIn(completion: (() -> Void)? = nil) {
        if alpha >= 1.0 {
            return
        }
        
        alpha = 0.0
        isHidden = false
        
        UIView.animate(withDuration: cAnimationDuration, delay: 0.0, options: .curveEaseIn, animations: { [weak self] in
            self?.alpha = 1.0
        }) { (_) in
            completion?()
        }
    }
    
    func fadeOut(completion: (() -> Void)? = nil) {
        if alpha <= 0 {
            return
        }
        
        alpha = 1.0
        isHidden = false
        
        UIView.animate(withDuration: cAnimationDuration, delay: 0.0, options: .curveEaseOut, animations: { [weak self] in
            self?.alpha = 0.0
        }) { (_) in
            completion?()
        }
    }
    
    func fadeOutAndPop() {
        alpha = 1.0
        isHidden = false
        
        UIView.animate(withDuration: cAnimationDuration, delay: 0, options: .curveEaseOut, animations: { [weak self] in
            self?.alpha = 0.0
        }) { (finished) in
            self.removeFromSuperview()
        }
    }
    
    func toggleFadeInOut() {
        alpha <= 0 ? fadeIn() : fadeOut()
    }
}
