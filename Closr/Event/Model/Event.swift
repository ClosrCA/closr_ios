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
    var time: String?
    var date: String?
    var purpose: String?
    var minAge: Double?
    var maxAge: Double?
    var numberOfPeople: Int = 2
    var gender: String?
    
    var rawDate: Date? {
        guard let time = time, let date = date else {
            return nil
        }
        
        let timeFormatter           = DateFormatter()
        timeFormatter.dateFormat    = String.createEventFullTimeFormat
        
        let timeString = date.appending(" \(time)")
        
        return timeFormatter.date(from: timeString)
    }
    
    init(restaurant: YelpPlace) {
        self.restaurant = restaurant
    }
}
