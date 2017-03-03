//
//  CreateEventViewController.swift
//  Closr
//
//  Created by Tao on 2017-03-01.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit
import EasyPeasy

class CreateEventViewController: UIViewController {
    
    var place: YelpPlace? {
        didSet {
            tableView.reloadData()
        }
    }
    
    fileprivate lazy var tableView: UITableView = {
        let tableView                                       = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource                                = self
        tableView.estimatedRowHeight                        = 44
        tableView.rowHeight                                 = UITableViewAutomaticDimension
        tableView.allowsSelection                           = false
        tableView.separatorStyle                            = .none
        
        tableView.register(TextFieldTableViewCell.self, forCellReuseIdentifier: TextFieldTableViewCell.reuseIdentifier)
        
        return tableView
    }()
    
    fileprivate lazy var datePicker: UIDatePicker = {
        let datePicker              = UIDatePicker()
        datePicker.datePickerMode   = .date
        datePicker.minimumDate      = Date()
        
        return datePicker
    }()
    
    fileprivate lazy var timePicker: UIDatePicker = {
        let timePicker              = UIDatePicker()
        timePicker.datePickerMode   = .time
        timePicker.minimumDate      = Date()
        
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
        toolBar.tintColor   = UIColor.brandColor
        
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(onDonePicking))
        let leftSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolBar.items = [leftSpace, doneItem]
            
        return toolBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        buildUI()
    }
    
    fileprivate func buildUI() {
        
        let closeItem = UIBarButtonItem(title: "X", style: .plain, target: self, action: #selector(onClose))
        navigationController?.navigationBar.tintColor = UIColor.gray
        navigationItem.leftBarButtonItem = closeItem
        
        view.addSubview(tableView)
        tableView <- Edges()
    }
    
    @objc
    fileprivate func onClose() {
        presentingViewController?.dismiss(animated: true)
    }
    
    @objc
    fileprivate func onDonePicking() {
        
    }
}

extension CreateEventViewController: UITableViewDataSource {
    
    fileprivate enum Section: Int {
        case textField
        case ageFilter
        case numberFilter
        case count
    }
    
    fileprivate enum TextFieldRow: Int {
        case address
        case date
        case time
        case purpose
        case count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.count.rawValue
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let section = Section(rawValue: section) {
            switch section {
            case .textField: return TextFieldRow.count.rawValue
            case .numberFilter: return 2
            default: return 0
            }
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let section = Section(rawValue: indexPath.section) {
            switch section {
            case .textField:
                
                if let row = TextFieldRow(rawValue: indexPath.row) {
                    
                    let cell = tableView.dequeueReusableCell(withIdentifier: TextFieldTableViewCell.reuseIdentifier, for: indexPath) as! TextFieldTableViewCell
                    
                    switch row {
                    case .address:
                        cell.update(title: "Address", text: place?.address?.displayAddress?.first, inputView: nil, isEditable: false)
                    case .date:
                        cell.update(title: "Date", text: datePicker.date.description, inputView: datePicker, inputAccessoryView: toolBar)
                    case .time:
                        cell.update(title: "Time", text: nil, inputView: timePicker, inputAccessoryView: toolBar)
                    case .purpose:
                        cell.update(title: "Purpose", text: nil, inputView: purposePicker, inputAccessoryView: toolBar)
                    default:
                        break
                    }
                    
                    return cell
                }
                
            default:
                break
            }
        }
        
        return UITableViewCell()
    }
}

extension CreateEventViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
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
}
