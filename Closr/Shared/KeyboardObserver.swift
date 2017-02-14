//
//  KeyboardObserver.swift
//  Closr
//
//  Created by Tao on 2017-02-14.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit

typealias KeyboardDidShow = (CGSize) -> Void
typealias KeyboardDidHide = (CGSize) -> Void

class KeyboardObserver {
    
    fileprivate var didShowObserver: NSObjectProtocol?
    fileprivate var didHideObserver: NSObjectProtocol?
    
    func addObserver(didAppear: @escaping KeyboardDidShow, didHide: @escaping KeyboardDidHide) {
        
        didShowObserver = NotificationCenter.default.addObserver(forName: .UIKeyboardWillShow, object: nil, queue: OperationQueue.main) { (notification) in
            
            if let keyboardRect = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect {
                didAppear(keyboardRect.size)
            }
        }
        
        didHideObserver = NotificationCenter.default.addObserver(forName: .UIKeyboardWillHide, object: nil, queue: OperationQueue.main) { (notification) in
            
            if let keyboardRect = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect {
                didHide(keyboardRect.size)
            }
        }
        
    }
    
    deinit {
        
        if let didShowObserver = didShowObserver {
            NotificationCenter.default.removeObserver(didShowObserver)
        }
        if let didHideObserver = didHideObserver {
            NotificationCenter.default.removeObserver(didHideObserver)
        }
    }
}
