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
    func textFieldTableViewCellDidFinishEditing(cell: TextFieldTableViewCell, rowType: TextFieldRowType?)
    func textFieldTableViewCellDidBeginEditing(cell: TextFieldTableViewCell)
}

class TextFieldTableViewCell: UITableViewCell, Reusable {
    
    fileprivate struct Constants {
        static let contentPadding: CGFloat              = 27
        static let textFieldVerticalPadding: CGFloat    = 7
        static let textFieldHeight: CGFloat             = 23
        
    }
    
    weak var delegate: TextFieldTableViewCellDelegate?
    
    fileprivate var fieldType: TextFieldRowType?
    
    fileprivate lazy var headlineLabel: UILabel = UILabel.makeLabel(font: AppFont.text, textColor: AppColor.text_gray)
    
    fileprivate lazy var textField: UITextField = {
        let textField                                       = UITextField()
        textField.backgroundColor                           = UIColor.white
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
    
    func update(title: String?, type: TextFieldRowType) {
        
        fieldType = type
        headlineLabel.text = title
        
        switch type {
        
        case .date(let raw):
            textField.layer.borderWidth = 0.5
            textField.layer.cornerRadius = 7
            textField.layer.borderColor = AppColor.brand.cgColor
            textField.inputView = datePicker
            
            let rawDate = raw ?? Date()
            let formatter           = DateFormatter()
            formatter.dateFormat    = String.createEventDateFormat
            textField.text          = formatter.string(from: rawDate)
            textFieldDidEndEditing(textField)
        case .time(let raw):
            textField.layer.borderWidth = 0.5
            textField.layer.borderColor = AppColor.brand.cgColor
            textField.inputView = timePicker
            
            let rawDate = raw ?? Date()
            let formatter           = DateFormatter()
            formatter.dateFormat    = String.createEventTimeFormat
            textField.text          = formatter.string(from: rawDate)
            textFieldDidEndEditing(textField)
        case .title(let title):
            textField.text = title
            textField.layer.borderWidth = 0.5
            textField.layer.borderColor = AppColor.brand.cgColor
            textField.easy.layout(
                Height(23),
                Width(321.1)
            )
        case .purpose(let purpose):
            textField.layer.borderWidth = 0.5
            textField.layer.borderColor = AppColor.brand.cgColor
            textField.inputView = purposePicker
            
            if purpose == nil {
                pickerView(purposePicker, didSelectRow: 0, inComponent: 0)
            } else {
                textField.text = purpose
            }
        case .share(let share):
            textField.text = share
            textField.layer.borderWidth = 0.5
            textField.layer.borderColor = AppColor.brand.cgColor
            textField.easy.layout(
                Height(47),
                Width(321.1)
            )
        }
        
        textField.inputAccessoryView    = toolBar
        textField.backgroundColor       = UIColor.white
        textField.borderStyle           = .roundedRect
        textField.isUserInteractionEnabled  = true
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(headlineLabel)
        contentView.addSubview(textField)
        
        createConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    fileprivate func onDonePicking() {
        textField.resignFirstResponder()
        delegate?.textFieldTableViewCellDidFinishEditing(cell: self, rowType: fieldType)
    }
    
    @objc
    fileprivate func onTimeSelected() {
        let formatter = DateFormatter()
        formatter.dateFormat = String.createEventTimeFormat
        
        textField.text = formatter.string(from: timePicker.date)
        fieldType = .time(timePicker.date)
    }
    
    @objc
    fileprivate func onDateSelected() {
        let formatter = DateFormatter()
        formatter.dateFormat = String.createEventDateFormat
        
        textField.text = formatter.string(from: datePicker.date)
        fieldType = .date(datePicker.date)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        headlineLabel.text                                     = nil
        textField.text                                      = nil
        textField.backgroundColor                           = UIColor.lightGray
        textField.borderStyle                               = .roundedRect
        textField.inputView                                 = nil
        textField.inputAccessoryView                        = nil
        fieldType                                           = nil
    }
    
    fileprivate func createConstraints() {
        headlineLabel.easy.layout(
            Top(Constants.textFieldVerticalPadding),
            Leading(Constants.contentPadding)
        )
        
        textField.easy.layout(
            Top(Constants.textFieldVerticalPadding).to(headlineLabel),
            Leading(Constants.contentPadding),
            Trailing(Constants.contentPadding),
            Bottom(Constants.textFieldVerticalPadding),
            Height(Constants.textFieldHeight)
        )
    }
    
}

extension TextFieldTableViewCell: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.textFieldTableViewCellDidBeginEditing(cell: self)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let fieldType = fieldType else { return }
        if case .title = fieldType {
            self.fieldType = .title(textField.text)
        }
        if case .share = fieldType {
            self.fieldType = .share(textField.text)
        }
        delegate?.textFieldTableViewCellDidFinishEditing(cell: self, rowType: self.fieldType)
    }
}

extension TextFieldTableViewCell: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Purpose.forDisplay.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Purpose.forDisplay[row].description
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let purpose = Purpose.forDisplay[row]
        textField.text = purpose.description
        fieldType = .purpose(purpose.description)
    }
}
