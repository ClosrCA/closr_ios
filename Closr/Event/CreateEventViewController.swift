//
//  CreateEventViewController.swift
//  Closr
//
//  Created by Tao on 2017-03-01.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit
import EasyPeasy
import SwaggerClient

class CreateEventViewController: UIViewController {
    
    var place: YelpPlace? {
        didSet {
            tableView.reloadData()
            
            if let restaurant = place {
                eventForm.yelpID = restaurant.placeID
            }
        }
    }
    
    fileprivate var eventForm = EventCreate()
    
    
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
    
    fileprivate lazy var createEventButton: UIButton = {
        let button = UIButton()
        button.setTitle("ADD NEW EVENT", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setBackgroundColor(color: AppColor.brand, for: .normal)
        button.addTarget(self, action: #selector(onCreateEvent), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavItem()
        
        buildUI()
    }
    
    fileprivate func setupNavItem() {
        
        let closeItem = UIBarButtonItem(title: "X", style: .plain, target: self, action: #selector(onClose))
        navigationController?.navigationBar.tintColor = UIColor.gray
        navigationItem.leftBarButtonItem = closeItem
    }
    
    fileprivate func buildUI() {
        view.addSubview(tableView)
        view.addSubview(createEventButton)
        
        tableView.easy.layout(
            Top(),
            Leading(),
            Trailing(),
            Bottom(AppSizeMetric.buttonHeight)
        )
        
        createEventButton.easy.layout(
            Height(AppSizeMetric.buttonHeight),
            Leading(),
            Bottom(),
            Trailing()
        )
    }
    
    @objc
    fileprivate func onClose() {
        presentingViewController?.dismiss(animated: true)
    }
    
    @objc
    fileprivate func onCreateEvent() {
        LoadingController.startLoadingOn(self)
        EventAPI.createEvent(authorization: UserAuthenticator.currentToken ?? "", eventCreate: eventForm) { (response, error) in
            
            LoadingController.stopLoading()
            
            guard error == nil else {
                self.popAlert(with: error.debugDescription)
                return
            }
            
            self.presentingViewController?.dismiss(animated: true)
        }
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
                    // TODO: parse date and time from single start time property
                    case .date:
                        cell.update(title: "Date", text: eventForm.startTime, section: .date)
                    case .time:
                        cell.update(title: "Time", text: eventForm.startTime, section: .time)
                    case .eventName:
                        cell.update(title: "Event Name", text: place?.address?.displayAddress?.first, section: .eventName)
                    case .purpose:
                        cell.update(title: "Purpose", text: eventForm.purpose, section: .purpose)
                    case .share:
                        cell.update(title: "Anything you'd to share", text: eventForm.description, section: .share)
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
            return eventForm.capacity == 2 ? UITableViewAutomaticDimension : 0
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
                eventForm.startTime = text
            case .time:
                eventForm.startTime = text
            case .purpose:
                eventForm.purpose = text
            default:
                break 
            }
        }
    }
}

extension CreateEventViewController: RangeSliderTableViewCellDelegate {
    func rangeSliderDidChangeRange(_ cell: RangeSliderTableViewCell, minValue: Double, maxValue: Double) {
        eventForm.minAge = minValue
        eventForm.maxAge = maxValue
    }
}

extension CreateEventViewController: SegmentControlTableViewCellDelegate {
    
    enum NumberOfPeople: Int {
        case two = 2
        case three = 3
        case four = 4
        
        static let segmentItems = ["2", "3", "4"]
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
            eventForm.capacity = Double((NumberOfPeople(rawValue: index) ?? .three).rawValue)
            
            tableView.beginUpdates()
            tableView.endUpdates()
            
        } else {
            eventForm.gender = Gender(rawValue: index)?.description
        }
    }
}
