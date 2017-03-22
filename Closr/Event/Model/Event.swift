//
//  Event.swift
//  Closr
//
//  Created by ZHITAO TIAN on 2017-03-22.
//  Copyright © 2017 closr. All rights reserved.
//

import Foundation

struct Event {
    var restaurant: YelpPlace
    var time: Date
    var purpose: String
    
    init(restaurant: YelpPlace, date: String, when: String, purpose: String) {
        self.restaurant = restaurant
        self.purpose    = purpose
        
        let timeFormatter           = DateFormatter()
        timeFormatter.dateFormat    = String.createEventFullTimeFormat
        
        let timeString = date.appending(" \(when)")
        time = timeFormatter.date(from: timeString) ?? Date()
    }
}
