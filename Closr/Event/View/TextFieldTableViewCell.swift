//
//  TextFieldTableViewCell.swift
//  Closr
//
//  Created by Tao on 2017-03-01.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit
import EasyPeasy

protocol TextFieldTableViewCellDelegate: class {
    func textFieldTableViewCellDidFinishEditing(cell: TextFieldTableViewCell)
    func textFieldTableViewCellDidBeginEditing(cell: TextFieldTableViewCell)
}

class TextFieldTableViewCell: UITableViewCell, Reusable {

    weak var delegate: TextFieldTableViewCellDelegate?
    
    fileprivate lazy var titleLabel: UILabel = {
        let label                                       = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    fileprivate lazy var textField: UITextField = {
        let textField                                       = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor                           = UIColor.lightGray
        textField.borderStyle                               = .roundedRect
        textField.delegate                                  = self
        
        return textField
    }()
    
    func update(title: String?, text: String?, inputView: UIView?, inputAccessoryView: UIView? = nil, isEditable: Bool = true) {
        
        titleLabel.text = title
        
        textField.text                  = text
        textField.inputView             = inputView
        textField.inputAccessoryView    = inputAccessoryView
        
        textField.backgroundColor = isEditable ? UIColor.lightGray : UIColor.white
        textField.borderStyle     = isEditable ? .roundedRect : .none
        
        textField.isUserInteractionEnabled  = isEditable
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(textField)
        
        createConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text                                     = nil
        textField.text                                      = nil
        textField.backgroundColor                           = UIColor.lightGray
        textField.borderStyle                               = .roundedRect
        textField.inputView                                 = nil
        textField.inputAccessoryView                        = nil
    }
    
    fileprivate func createConstraints() {
        titleLabel <- [
            Top(8),
            Leading(10),
            Trailing(10)
        ]
        
        textField <- [
            Top(8).to(titleLabel, .bottom),
            Leading().to(titleLabel, .leading),
            Trailing().to(titleLabel, .trailing),
            Bottom(8),
            Height(40)
        ]
    }
    
}

extension TextFieldTableViewCell: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.textFieldTableViewCellDidBeginEditing(cell: self)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.textFieldTableViewCellDidFinishEditing(cell: self)
    }
}
