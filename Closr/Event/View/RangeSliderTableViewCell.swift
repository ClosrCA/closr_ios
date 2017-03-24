//
//  RangeSliderTableViewCell.swift
//  Closr
//
//  Created by Tao on 2017-03-01.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit
import EasyPeasy
import WARangeSlider

protocol RangeSliderTableViewCellDelegate: class {
    func rangeSliderDidChangeRange(_ cell: RangeSliderTableViewCell, minValue: Double, maxValue: Double)
}

class RangeSliderTableViewCell: UITableViewCell, Reusable {

    struct Constants {
        static let minAge: Double = 18
        static let maxAge: Double = 80
    }
    
    weak var delegate: RangeSliderTableViewCellDelegate?
    
    fileprivate lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Age"
        
        return label
    }()
    
    fileprivate lazy var rangeLabel: UILabel = {
        let label       = UILabel()
        label.textColor = UIColor.brandColor
        label.text      = "no age limit"
        
        return label
    }()
    
    fileprivate lazy var rangeSlider: RangeSlider = {
        let rangeSlider = RangeSlider()
        rangeSlider.lowerValue = 0
        rangeSlider.upperValue = 1
        rangeSlider.trackTintColor = UIColor.lightGray
        rangeSlider.trackHighlightTintColor = UIColor.brandColor
        rangeSlider.thumbTintColor = UIColor.brandColor
        
        rangeSlider.addTarget(self, action: #selector(onRangeChanged(sender:)), for: .valueChanged)
        
        return rangeSlider
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(rangeLabel)
        contentView.addSubview(rangeSlider)
        
        createConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    fileprivate func onRangeChanged(sender: RangeSlider) {
        let lowerAge = floor(sender.lowerValue * (Constants.maxAge - Constants.minAge) + Constants.minAge)
        let upperAge = floor(sender.upperValue * (Constants.maxAge - Constants.minAge) + Constants.minAge)
        
        rangeLabel.text = "\(Int(lowerAge))-\(Int(upperAge))"
        
        delegate?.rangeSliderDidChangeRange(self, minValue: lowerAge, maxValue: upperAge)
    }
    
    fileprivate func createConstraints() {
        titleLabel <- [
            Leading(10),
            Top(8)
        ]
        
        rangeLabel <- [
            Trailing(10),
            Top(8)
        ]
        
        rangeSlider <- [
            Top(10).to(titleLabel, .bottom),
            Leading(10),
            Trailing(10),
            Height(44),
            Bottom(8)
        ]
    }

}
