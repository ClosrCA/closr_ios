//
//  Notification.swift
//  Closr
//
//  Created by Zhitao on 2017-02-17.
//  Copyright © 2017 closr. All rights reserved.
//

import Foundation

struct NotificationName {
    static let login            = Notification.Name(rawValue: "user_login_notification")
    static let signout          = Notification.Name(rawValue: "user_signout_notification")
    static let unauthenticated  = Notification.Name(rawValue: "user_unauthenticated_notification")
}
