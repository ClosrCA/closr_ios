
//
//  ChatAvatar.swift
//  Closr
//
//  Created by ZHITAO TIAN on 2017-08-27.
//  Copyright © 2017 closr. All rights reserved.
//

import Foundation
import JSQMessagesViewController

class ChatAvatar: NSObject, JSQMessageAvatarImageDataSource {
    
    var avatarURL: String?
    
    func avatarPlaceholderImage() -> UIImage! {
        return UIImage(named: "icon_user")
    }

    
    func avatarHighlightedImage() -> UIImage! {
        return nil
    }

    
    func avatarImage() -> UIImage! {
        return UIImage.loadImage(url: avatarURL)
    }
    
}
