//
//  UIViewController+Popup.swift
//  Closr
//
//  Created by ZHITAO TIAN on 2018-05-27.
//  Copyright © 2018 closr. All rights reserved.
//

import UIKit

extension UIViewController {
    func popAlert(with message: String?) {
        let alertController = UIAlertController(title: "Ooops", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        
        present(alertController, animated: true)
    }
}

