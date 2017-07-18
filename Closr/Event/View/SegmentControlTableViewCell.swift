//
//  SegmentControlTableViewCell.swift
//  Closr
//
//  Created by ZHITAO TIAN on 2017-03-24.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit
import EasyPeasy

protocol SegmentControlTableViewCellDelegate: class {
    func segmentControlTableViewCell(_ cell: SegmentControlTableViewCell, didSelect index: Int)
}

class SegmentControlTableViewCell: UITableViewCell, Reusable {

    struct Constants {
        static let titlePadding: CGFloat = 23
        static let titleTopPadding: CGFloat = 10
        static let segmentControlPadding: CGFloat = 10
        static let segmentControlHeight: CGFloat = 28
    }
    
    weak var delegate: SegmentControlTableViewCellDelegate?
    
    fileprivate lazy var titleLabel: UILabel = UILabel.makeLabel(font: AppFont.text, textColor: AppColor.blackText)
    
    fileprivate lazy var segmentControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl()
        segmentControl.tintColor = AppColor.brand
        
        segmentControl.addTarget(self, action: #selector(onSegmentSelected(sender:)), for: .valueChanged)
        
        return segmentControl
    }()
    
    func update(title: String?, items: [String], selectedIndex: Int) {
        titleLabel.text = title
        
        for (index, title) in items.enumerated() {
            segmentControl.insertSegment(withTitle: title, at: index, animated: false)
        }
        
        if selectedIndex < segmentControl.numberOfSegments {
            segmentControl.selectedSegmentIndex = selectedIndex
        }
        
        setNeedsUpdateConstraints()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(segmentControl)
        
        clipsToBounds = true
        
        createConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = nil
        segmentControl.removeAllSegments()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        if titleLabel.text?.isEmpty ?? true {
            segmentControl <- Top(Constants.segmentControlPadding)
        } else {
            segmentControl <- Top(Constants.segmentControlPadding).to(titleLabel, .bottom)
        }
    }
    
    fileprivate func createConstraints() {
        titleLabel <- [
            Leading(Constants.titlePadding),
            Top(Constants.titleTopPadding)
        ]
        
        segmentControl <- [
            Top(12).to(titleLabel),
            Leading(Constants.titlePadding),
            Trailing(Constants.titlePadding),
            Bottom(31),
            Height(Constants.segmentControlHeight)
        ]
    }
    
    @objc
    fileprivate func onSegmentSelected(sender: UISegmentedControl) {
        delegate?.segmentControlTableViewCell(self, didSelect: sender.selectedSegmentIndex)
    }
}
