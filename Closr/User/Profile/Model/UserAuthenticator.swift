//
//  UserAuthenticator.swift
//  Closr
//
//  Created by Tao on 2017-02-12.
//  Copyright © 2017 closr. All rights reserved.
//

import Foundation
import SwiftyJSON
import FirebaseAuth
import SwaggerClient

struct UserAuthenticator {
    
    static var currentProfile: Profile?
    
    static var currentToken: String?
    
    static func logout() throws {
        try Auth.auth().signOut()
        currentProfile  = nil
        currentToken    = nil
    }
    
    static func populateProfile(with userInfo: UserInfo) {
        let profile             = Profile()
        profile.displayName     = userInfo.displayName
        profile.email           = userInfo.email
        profile.phone           = userInfo.phoneNumber
        profile.avatar          = userInfo.photoURL?.absoluteString
        
        currentProfile = profile
    }
}
