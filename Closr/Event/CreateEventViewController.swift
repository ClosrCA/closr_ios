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
        tableView.dataSource                                = self
        tableView.estimatedRowHeight                        = 44
        tableView.rowHeight                                 = UITableViewAutomaticDimension
        tableView.allowsSelection                           = false
        tableView.separatorStyle                            = .none
        
        tableView.register(TextFieldTableViewCell.self, forCellReuseIdentifier: TextFieldTableViewCell.reuseIdentifier)
        
        return tableView
    }()
    
    fileprivate var m_dateString: String?
    fileprivate var m_timeString: String?
    fileprivate var m_purposeString: String?
    
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
                    
                    let cell        = tableView.dequeueReusableCell(withIdentifier: TextFieldTableViewCell.reuseIdentifier, for: indexPath) as! TextFieldTableViewCell
                    
                    cell.delegate   = self
                    
                    switch row {
                    case .address:
                        cell.update(title: "Address", text: place?.address?.displayAddress?.first, section: .address)
                    case .date:
                        cell.update(title: "Date", text: m_dateString, section: .date)
                    case .time:
                        cell.update(title: "Time", text: m_timeString, section: .time)
                    case .purpose:
                        cell.update(title: "Purpose", text: m_purposeString, section: .purpose)
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

extension CreateEventViewController: TextFieldTableViewCellDelegate {
    func textFieldTableViewCellDidBeginEditing(cell: TextFieldTableViewCell) {
        
    }
    
    func textFieldTableViewCellDidFinishEditing(cell: TextFieldTableViewCell, text: String?) {
        if let row = tableView.indexPath(for: cell)?.row,
            let section = TextFieldRow(rawValue: row) {
            switch section {
            case .date:
                m_dateString = text
            case .time:
                m_timeString = text
            case .purpose:
                m_purposeString = text
            default:
                break 
            }
        }
    }
}
