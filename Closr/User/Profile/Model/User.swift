//
//  User.swift
//  Closr
//
//  Created by Tao on 2017-02-12.
//  Copyright © 2017 closr. All rights reserved.
//

import Foundation
import SwiftyJSON
import FirebaseAuth

struct User {
    
    static var current: User?
    
    static func logout() throws {
        try Auth.auth().signOut()
        current = nil
    }
    
    enum Gender: String {
        case female = "female"
        case male   = "male"
        
        var title: String {
            switch self {
            case .female: return "Female"
            case .male: return "Male"
            }
        }
    }
    
    var facebookID: String?
    var firbaseID: String?
    var name: String?
    var birthday: Date?
    var gender: Gender?
    var email: String?
    var phone: String?
    var avatar: String?
    
    init(name: String?, birthday: Date?, gender: Gender?, email: String?, phone: String?, avatar: String?) {
        self.name = name
        self.birthday = birthday
        self.gender = gender
        self.email = email
        self.phone = phone
        self.avatar = avatar
    }
    
    init(profile: JSON) {
        
        facebookID = profile["id"].string
        name = profile["name"].string
        gender = Gender(rawValue: profile["gender"].stringValue)
        email = profile["email"].string
        phone = profile["phone"].string
        avatar = profile["picture"]["data"]["url"].string
        
        if let birthday = profile["birthday"].string {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = String.birthdayFormat_fb
            self.birthday = dateFormatter.date(from: birthday)
        }
    }
}
