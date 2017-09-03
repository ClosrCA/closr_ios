//
//  ProfileFormTableViewCell.swift
//  Closr
//
//  Created by ZHITAO TIAN on 2017-09-02.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit
import EasyPeasy

protocol ProfileFormTableViewCellDataSource: class {
    func title(for cell: ProfileFormTableViewCell) -> String?
    func text(for cell: ProfileFormTableViewCell) -> String?
    func keyboardType(for cell: ProfileFormTableViewCell) -> UIKeyboardType
    func inputView(for cell: ProfileFormTableViewCell) -> UIView?
    func inputAccesaryView(for cell: ProfileFormTableViewCell) -> UIView?
}

protocol ProfileFormTableViewCellDelegate: class {
    func didReturn(text: String?, from cell: ProfileFormTableViewCell)
    func didEndEditing(text: String?, from cell: ProfileFormTableViewCell)
}

class ProfileFormTableViewCell: UITableViewCell, Reusable {

    weak var dataSource: ProfileFormTableViewCellDataSource?
    weak var delegate: ProfileFormTableViewCellDelegate?
    
    override var isFirstResponder: Bool {
        return textField.isFirstResponder
    }
    
    fileprivate lazy var titleLabel: UILabel = UILabel.makeLabel(font: AppFont.text, textColor: AppColor.text_gray)
    
    fileprivate lazy var textField: UITextField = {
        let textField           = UITextField()
        textField.borderStyle   = .none
        textField.font          = AppFont.text
        textField.textColor     = AppColor.text_dark
        textField.delegate      = self
        textField.tintColor     = AppColor.text_dark
        
        return textField
    }()
    
    fileprivate lazy var underLine: UIView = {
        let view                = UIView()
        view.backgroundColor    = AppColor.background_brand
        
        return view
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(textField)
        contentView.addSubview(underLine)
        
        createConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.text                 = dataSource?.title(for: self)
        textField.text                  = dataSource?.text(for: self)
        textField.placeholder           = dataSource?.title(for: self)
        textField.inputView             = dataSource?.inputView(for: self)
        textField.inputAccessoryView    = dataSource?.inputAccesaryView(for: self)
        textField.keyboardType          = dataSource?.keyboardType(for: self) ?? .default
        
        animateTitleIfNeeded(text: textField.text)
    }
    
    fileprivate func createConstraints() {
        titleLabel <- [
            Top(AppSizeMetric.defaultPadding),
            Leading(AppSizeMetric.breathPadding),
            Height(20)
        ]
        
        textField <- [
            Top(AppSizeMetric.defaultPadding).to(titleLabel),
            Leading(AppSizeMetric.breathPadding),
            Trailing(AppSizeMetric.breathPadding),
            Height(AppSizeMetric.textFieldHeight),
            Bottom(AppSizeMetric.defaultPadding)
        ]
        
        underLine <- [
            Leading(AppSizeMetric.breathPadding),
            Trailing(AppSizeMetric.breathPadding),
            Top().to(textField),
            Height(2)
        ]
    }
    
    fileprivate func animateTitleIfNeeded(text: String?) {
        if text?.isEmpty ?? true {
            titleLabel.fadeOut()
        } else {
            titleLabel.fadeIn()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfileFormTableViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.didReturn(text: textField.text, from: self)
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.didEndEditing(text: textField.text, from: self)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text else {
            animateTitleIfNeeded(text: nil)
            return true
        }
        
        let textFieldRange = NSMakeRange(0, text.characters.count)
        if NSEqualRanges(textFieldRange, range) && string.isEmpty {
            animateTitleIfNeeded(text: nil)
        } else {
            animateTitleIfNeeded(text: " ")
        }
        
        return true
    }
    
}
