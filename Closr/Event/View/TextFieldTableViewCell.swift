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
    func textFieldTableViewCellDidFinishEditing(cell: TextFieldTableViewCell, text: String?)
    func textFieldTableViewCellDidBeginEditing(cell: TextFieldTableViewCell)
}

class TextFieldTableViewCell: UITableViewCell, Reusable {

    enum Section {
        case address
        case date
        case time
        case purpose
    }
    
    fileprivate struct Constants {
        static let contentPadding: CGFloat              = 10
        static let textFieldVerticalPadding: CGFloat    = 8
        static let textFieldHeight: CGFloat             = 30
    }
    
    weak var delegate: TextFieldTableViewCellDelegate?
    
    fileprivate lazy var titleLabel: UILabel = UILabel.makeLable(font: AppFont.text, textColor: AppColor.greyText)
    
    fileprivate lazy var textField: UITextField = {
        let textField                                       = UITextField()
        textField.backgroundColor                           = UIColor.lightGray
        textField.borderStyle                               = .roundedRect
        textField.delegate                                  = self
        
        return textField
    }()
    
    fileprivate lazy var datePicker: UIDatePicker = {
        let datePicker              = UIDatePicker()
        datePicker.datePickerMode   = .date
        datePicker.minimumDate      = Date()
        datePicker.addTarget(self, action: #selector(onDateSelected), for: .valueChanged)
        
        return datePicker
    }()
    
    fileprivate lazy var timePicker: UIDatePicker = {
        let timePicker              = UIDatePicker()
        timePicker.datePickerMode   = .time
        timePicker.addTarget(self, action: #selector(onTimeSelected), for: .valueChanged)
        
        return timePicker
    }()
    
    fileprivate lazy var purposePicker: UIPickerView = {
        let picker          = UIPickerView()
        picker.delegate     = self
        picker.dataSource   = self
        
        return picker
    }()
    
    fileprivate lazy var toolBar: UIToolbar = {
        let toolBar         = UIToolbar(frame: CGRect(x: 0, y: 0, width: 0, height: 44))
        toolBar.tintColor   = AppColor.brand
        
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(onDonePicking))
        let leftSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolBar.items = [leftSpace, doneItem]
        
        return toolBar
    }()
    
    func update(title: String?, text: String?, section: Section) {
        
        titleLabel.text = title
        
        switch section {
        case .address:
            textField.text  = text
            textField.backgroundColor = UIColor.white
            textField.borderStyle     = .none
            textField.isUserInteractionEnabled = false
            return
        case .date:
            let formatter           = DateFormatter()
            formatter.dateFormat    = String.createEventDateFormat
            textField.text          = formatter.string(from: Date())
            
            textField.inputView = datePicker
        case .time:
            let formatter           = DateFormatter()
            formatter.dateFormat    = String.createEventTimeFormat
            textField.text          = formatter.string(from: Date())
            
            textField.inputView = timePicker
        case .purpose:
            textField.inputView = purposePicker
        }
        
        textField.inputAccessoryView    = toolBar
        textField.backgroundColor       = UIColor.lightGray
        textField.borderStyle           = .roundedRect
        
        textField.isUserInteractionEnabled  = true
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
    
    @objc
    fileprivate func onDonePicking() {
        textField.resignFirstResponder()
        delegate?.textFieldTableViewCellDidFinishEditing(cell: self, text: textField.text)
    }
    
    @objc
    fileprivate func onTimeSelected() {
        let formatter = DateFormatter()
        formatter.dateFormat = String.createEventTimeFormat
        
        textField.text = formatter.string(from: timePicker.date)
    }
    
    @objc
    fileprivate func onDateSelected() {
        let formatter = DateFormatter()
        formatter.dateFormat = String.createEventDateFormat
        
        textField.text = formatter.string(from: datePicker.date)
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
            Top(Constants.contentPadding),
            Leading(Constants.contentPadding)
        ]
        
        textField <- [
            Top(Constants.textFieldVerticalPadding).to(titleLabel),
            Leading(Constants.contentPadding),
            Trailing(Constants.contentPadding),
            Bottom(Constants.textFieldVerticalPadding),
            Height(Constants.textFieldHeight)
        ]
    }
    
}

extension TextFieldTableViewCell: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.textFieldTableViewCellDidBeginEditing(cell: self)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.textFieldTableViewCellDidFinishEditing(cell: self, text: textField.text)
    }
}

extension TextFieldTableViewCell: UIPickerViewDataSource, UIPickerViewDelegate {
    enum Purpose: Int, CustomStringConvertible {
        
        static let count = 4
        
        case business
        case casual
        case dating
        case foodie
        
        var description: String {
            switch self {
            case .business: return "Business/Networking"
            case .casual: return "Casual chatting"
            case .dating: return "Dating"
            case .foodie: return "Foodie lovers"
            }
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Purpose.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if let purpose = Purpose(rawValue: row) {
            return purpose.description
        }
        
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textField.text = Purpose(rawValue: row)?.description
    }
}
