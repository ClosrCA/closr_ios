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
            
            if let restaurant = place {
                event = Event(restaurant: restaurant)
            }
        }
    }
    
    fileprivate var event: Event?
    
    fileprivate lazy var tableView: UITableView = {
        let tableView                                       = UITableView(frame: .zero, style: .plain)
        tableView.dataSource                                = self
        tableView.delegate                                  = self
        tableView.estimatedRowHeight                        = 44
        tableView.allowsSelection                           = false
        tableView.separatorStyle                            = .none
        
        tableView.register(TextFieldTableViewCell.self, forCellReuseIdentifier: TextFieldTableViewCell.reuseIdentifier)
        tableView.register(RangeSliderTableViewCell.self, forCellReuseIdentifier: RangeSliderTableViewCell.reuseIdentifier)
        tableView.register(SegmentControlTableViewCell.self, forCellReuseIdentifier: SegmentControlTableViewCell.reuseIdentifier)
        
        return tableView
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
        
        tableView.tableFooterView = makeFooter()
    }
    
    @objc
    fileprivate func onClose() {
        presentingViewController?.dismiss(animated: true)
    }
    
    fileprivate func makeFooter() -> UIView {
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 24.73))
        
        let button = UIButton()
        button.setTitle("ADD NEW EVENT", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 9)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setBackgroundImage(UIImage.imageWith(color: AppColor.brand, within: CGSize(width: 1, height: 1)), for: .normal)
        button.addTarget(self, action: #selector(onCreateEvent), for: .touchUpInside)
        
        button.layer.cornerRadius = 2
        button.clipsToBounds = true
        
        footer.addSubview(button)
        
        button <- [
            Top(0),
            Bottom(0),
            Leading(96.9).with(.high),
            Trailing(96.9).with(.high)
        ]
        
        return footer
    }
    
    @objc
    fileprivate func onCreateEvent() {
        
        presentingViewController?.dismiss(animated: true)
    }
}

extension CreateEventViewController: UITableViewDataSource, UITableViewDelegate {
    
    fileprivate enum Section: Int {
        case textField
        case ageFilter
        case numberFilter
        case count
    }
    
    fileprivate enum TextFieldRow: Int {
        case date
        case time
        case eventName
        case purpose
        case share
        case count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.count.rawValue
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let section = Section(rawValue: section) {
            switch section {
            case .textField:
                return TextFieldRow.count.rawValue
            case .ageFilter:
                return 1
            case .numberFilter:
                return 2
            default:
                break
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
                    case .date:
                        cell.update(title: "Date", text: event?.date, section: .date)
                    case .time:
                        cell.update(title: "Time", text: event?.time, section: .time)
                    case .eventName:
                        cell.update(title: "Event Name", text: place?.address?.displayAddress?.first, section: .eventName)
                    case .purpose:
                        cell.update(title: "Purpose", text: event?.purpose, section: .purpose)
                    case .share:
                        cell.update(title: "Anything you'd to share", text: event?.share, section: .share)
                    default:
                        break
                    }
                    
                    return cell
                }
                
            case .ageFilter:
                
                let cell = tableView.dequeueReusableCell(withIdentifier: RangeSliderTableViewCell.reuseIdentifier, for: indexPath) as! RangeSliderTableViewCell
                
                cell.delegate = self
                
                return cell
                
            case .numberFilter:
                
                let cell = tableView.dequeueReusableCell(withIdentifier: SegmentControlTableViewCell.reuseIdentifier, for: indexPath) as! SegmentControlTableViewCell
                
                cell.delegate = self
                
                if indexPath.row == 0 {
                    cell.update(title: "No. of People", items: NumberOfPeople.segmentItems, selectedIndex: NumberOfPeople.three.rawValue)
                } else {
                    cell.update(title: nil, items: Gender.segmentItems, selectedIndex: 2)
                }
                
                return cell
            default:
                break
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isRowOfGender(indexPath: indexPath) {
            return event?.numberOfPeople == 2 ? UITableViewAutomaticDimension : 0
        }
        
        return UITableViewAutomaticDimension
    }
    
    fileprivate func isRowOfGender(indexPath: IndexPath) -> Bool {
        return indexPath.section == Section.numberFilter.rawValue && indexPath.row == 1
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
                event?.date = text
            case .time:
                event?.time = text
            case .purpose:
                event?.purpose = text
            default:
                break 
            }
        }
    }
}

extension CreateEventViewController: RangeSliderTableViewCellDelegate {
    func rangeSliderDidChangeRange(_ cell: RangeSliderTableViewCell, minValue: Double, maxValue: Double) {
        event?.minAge = minValue
        event?.maxAge = maxValue
    }
}

extension CreateEventViewController: SegmentControlTableViewCellDelegate {
    
    enum NumberOfPeople: Int {
        case two
        case three
        case four
        
        static let segmentItems = ["2", "3", "4"]
        
        var value: Int {
            switch self {
            case .two:
                return 2
            case .three:
                return 3
            case .four:
                return 4
            }
        }
    }
    
    enum Gender: Int {
        case female
        case male
        
        static let segmentItems = ["Female", "Male", "Doesn't matter"]
        
        var description: String {
            switch self {
            case .female:
                return "female"
            case .male:
                return "male"
            }
        }
    }
    
    func segmentControlTableViewCell(_ cell: SegmentControlTableViewCell, didSelect index: Int) {
        guard let row = tableView.indexPath(for: cell)?.row else {
            return
        }
        
        if row == 0 {
            event?.numberOfPeople = NumberOfPeople(rawValue: index)!.value
            
            tableView.beginUpdates()
            tableView.endUpdates()
            
        } else {
            event?.gender = Gender(rawValue: index)?.description
        }
    }
}
