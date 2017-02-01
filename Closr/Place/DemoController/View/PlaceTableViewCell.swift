//
//  PlaceTableViewCell.swift
//  Closr
//
//  Created by Tao on 2017-01-27.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit

class PlaceTableViewCell: UITableViewCell {

    @IBOutlet weak var previewImageView: UIImageView!
   
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        previewImageView.image = nil
        nameLabel.text = nil
        addressLabel.text = nil
    }
}
