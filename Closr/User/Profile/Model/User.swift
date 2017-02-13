//
//  User.swift
//  Closr
//
//  Created by Tao on 2017-02-12.
//  Copyright © 2017 closr. All rights reserved.
//

import Foundation
import SwiftyJSON

class User: NSObject, NSCoding {

    fileprivate static let userDefaultsKey = "closr_user_profile_key"
    
    enum Gender: String {
        case female = "female"
        case male   = "male"
    }
    
    var fbID: String?
    var name: String?
    var birthday: Date?
    var gender: Gender?
    var email: String?
    var phone: String?
    var avatar: String?
    
    init(name: String?, birthday: Date?, gender: Gender?, email: String?, phone: String?, avatar: String?) {
        super.init()
        
        self.name = name
        self.birthday = birthday
        self.gender = gender
        self.email = email
        self.phone = phone
        self.avatar = avatar
    }
    
    init(profile: JSON) {
        super.init()
        
        fbID = profile["id"].string
        name = profile["name"].string
        gender = Gender(rawValue: profile["gender"].stringValue)
        email = profile["email"].string
        phone = profile["phone"].string
        avatar = profile["picture"]["data"]["url"].string
        
        if let birthday = profile["birthday"].string {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = String.birthdayFormat
            self.birthday = dateFormatter.date(from: birthday)
        }
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(fbID, forKey: "facebookID")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(birthday, forKey: "birthday")
        aCoder.encode(gender?.rawValue, forKey: "gender")
        aCoder.encode(email, forKey: "email")
        aCoder.encode(phone, forKey: "phone")
        aCoder.encode(avatar, forKey: "avatar")
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        self.fbID = aDecoder.decodeObject(forKey: "facebookID") as? String
        self.name = aDecoder.decodeObject(forKey: "name") as? String
        self.birthday = aDecoder.decodeObject(forKey: "birthday") as? Date
        
        if let genderString = aDecoder.decodeObject(forKey: "gender") as? String {
            self.gender = Gender(rawValue: genderString)
        }
        
        self.email = aDecoder.decodeObject(forKey: "email") as? String
        self.phone = aDecoder.decodeObject(forKey: "phone") as? String
        self.avatar = aDecoder.decodeObject(forKey: "avatar") as? String
    }
}

extension User {
    
    class var currentUser: User? {
        if let data = UserDefaults.standard.data(forKey: User.userDefaultsKey) {
            return NSKeyedUnarchiver.unarchiveObject(with: data) as? User
        }
        
        return nil
    }
    
    func store() {
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: self)
        UserDefaults.standard.set(encodedData, forKey: User.userDefaultsKey)
    }
}
