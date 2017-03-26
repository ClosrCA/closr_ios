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
        static let labelPadding: CGFloat = 10
        static let sliderPadding: CGFloat = 10
        static let sliderHeight: CGFloat = 44
        
        static let minAge: Double = 19
        static let maxAge: Double = 80
    }
    
    
    weak var delegate: RangeSliderTableViewCellDelegate?
    
    fileprivate lazy var titleLabel: UILabel = UILabel.makeLable(font: AppFont.text, textColor: AppColor.greyText, text: "Age")
    
    fileprivate lazy var rangeLabel: UILabel = UILabel.makeLable(font: AppFont.text, textColor: AppColor.brand, text: "no age limit")
    
    fileprivate lazy var rangeSlider: RangeSlider = {
        let rangeSlider = RangeSlider()
        rangeSlider.lowerValue = 0
        rangeSlider.upperValue = 1
        rangeSlider.trackTintColor = UIColor.lightGray
        rangeSlider.trackHighlightTintColor = AppColor.brand
        rangeSlider.thumbTintColor = AppColor.brand
        
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
            Leading(Constants.labelPadding),
            Top(Constants.labelPadding)
        ]
        
        rangeLabel <- [
            Trailing(Constants.labelPadding),
            Top(Constants.labelPadding)
        ]
        
        rangeSlider <- [
            Top(Constants.sliderPadding).to(titleLabel, .bottom),
            Leading(Constants.sliderPadding),
            Trailing(Constants.sliderPadding),
            Height(Constants.sliderHeight),
            Bottom(Constants.sliderPadding)
        ]
    }

}
