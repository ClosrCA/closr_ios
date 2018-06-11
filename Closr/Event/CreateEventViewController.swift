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
import CoreLocation

enum Purpose: Int, CustomStringConvertible {
    
    static let forDisplay: [Purpose] = [.business, .foodie]
    
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
enum Section: Int {
    case textField
    case ageFilter
    case numberFilter
    case count
}

enum TextFieldRowType {
    
    static let rows: [TextFieldRowType] = [.date(nil), .time(nil), .title(nil), .purpose(nil), .share(nil)]
    
    case date(Date?)
    case time(Date?)
    case title(String?)
    case purpose(String?)
    case share(String?)
    
    var headline: String {
        switch self {
        case .date:
            return "Date"
        case .time:
            return "Start time"
        case .title:
            return "Event name"
        case .purpose:
            return "Purpose"
        case .share:
            return "Anything you'd like to share"
        }
    }
}

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
    fileprivate var startTime: (day: Date?, time: Date?)
    
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
        if let basicError = validateBasicsOnCreation() {
            popAlert(with: basicError)
            return
        }
        
        if let dateMissing = validateAndFormEventDate() {
            popAlert(with: dateMissing)
            return
        }
        
        if let locationMissing = validateUserLocation() {
            popAlert(with: locationMissing)
            return
        }
        
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
    
    fileprivate func validateAndFormEventDate() -> String? {
        guard let day = startTime.day, let time = startTime.time else {
            return "Please choose a day and time for the event"
        }
        
        let date = combine(day: day, time: time)
        eventForm.startTime = date?.description
        return nil
    }
    
    fileprivate func validateUserLocation() -> String? {
        let coordinate = Location.shared.current?.coordinate
        guard let lat = coordinate?.latitude, let lng = coordinate?.longitude else {
            return "Please enable location service in Settings"
        }
        eventForm.lat = lat
        eventForm.lng = lng
        return nil
    }
    
    fileprivate func validateBasicsOnCreation() -> String? {
        var errorMessage: String?
        if eventForm.yelpID == nil {
            errorMessage = "Can not create event on given restaurant"
        } else if eventForm.purpose == nil {
            errorMessage = "Please select a purpose"
        } else if eventForm.capacity == nil {
            errorMessage = "Please select the number of people"
        }
        return errorMessage
    }
    
    fileprivate func combine(day: Date, time: Date) -> Date? {
        let calendar = Calendar.current
        let timeComponents = calendar.dateComponents([.hour, .minute, .second], from: time)
        var dateCompnents = calendar.dateComponents([.year, .month, .day], from: day)
        dateCompnents.hour = timeComponents.hour
        dateCompnents.minute = timeComponents.minute
        dateCompnents.second = timeComponents.second
        
        return dateCompnents.date
    }
}

extension CreateEventViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.count.rawValue
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let section = Section(rawValue: section) {
            switch section {
            case .textField:
                return TextFieldRowType.rows.count
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
                
                let cell        = tableView.dequeueReusableCell(withIdentifier: TextFieldTableViewCell.reuseIdentifier, for: indexPath) as! TextFieldTableViewCell
                cell.delegate   = self
                
                let textFieldRow = TextFieldRowType.rows[indexPath.row]
                cell.update(title: textFieldRow.headline, type: textFieldRow)
                
                return cell
                
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
    func textFieldTableViewCellDidBeginEditing(cell: TextFieldTableViewCell) {}
    
    func textFieldTableViewCellDidFinishEditing(cell: TextFieldTableViewCell, rowType: TextFieldRowType?) {
        guard let row = rowType else { return }
        switch row {
        case .title(let text):
            eventForm.title = text
        case .date(let date):
            startTime.day = date
        case .time(let date):
            startTime.time = date
        case .purpose(let text):
            eventForm.purpose = text
        case .share(let text):
            eventForm.description = text
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
