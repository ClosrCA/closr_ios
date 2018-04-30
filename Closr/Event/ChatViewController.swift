//
//  ChatViewController.swift
//  Closr
//
//  Created by ZHITAO TIAN on 2018-02-21.
//  Copyright © 2018 closr. All rights reserved.
//

import UIKit
import EasyPeasy
import FirebaseAuth
import SwaggerClient

class ChatViewController: UIViewController {

    lazy var messageViewController: MessageViewController = {
        let controller = MessageViewController()
        controller.channelID            = self.event.id
        controller.senderId             = Auth.auth().currentUser?.uid
        controller.senderDisplayName    = Auth.auth().currentUser?.displayName
        controller.delegate             = self

        return controller
    }()
    
    lazy var headerViewController: ChatHeaderViewController = {
        let controller      = ChatHeaderViewController()
        controller.delegate = self
        
        return controller
    }()
    
    fileprivate var event: Event
    
    init(event: Event) {
        self.event = event
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addChildViewController(messageViewController)
        view.addSubview(messageViewController.view)
        messageViewController.didMove(toParentViewController: self)
        
        addChildViewController(headerViewController)
        view.addSubview(headerViewController.view)
        headerViewController.didMove(toParentViewController: self)
        
        createConstraints()
    }
    
    fileprivate func createConstraints() {
        headerViewController.view.easy.layout(
            Top(),
            Leading(),
            Trailing(),
            Height(ChatHeaderViewController.preferredHeight))
        
        messageViewController.view.easy.layout(
            Top().to(headerViewController.view),
            Leading(),
            Trailing(),
            Bottom())
    }
}

extension ChatViewController: MessageViewControllerDelegate {
    func chatAvatar(for firebaseId: String) -> ChatAvatar {
        let user = findUserBy(firebaseId: firebaseId)
        
        let avatar          = ChatAvatar()
        avatar.avatarURL    = user?.avatar
        
        return avatar
    }
}

extension ChatViewController: ChatHeaderViewControllerDelegate {
    func chatterName() -> [String] {
        guard let hostName = event.author?.displayName else {
            return [""]
        }
        
        guard let participants = event.attendees else {
            return [""]
        }
        
        var chatter = [hostName]
        let participantNames = participants.map{ $0.displayName ?? "" }
        
        chatter.append(contentsOf: participantNames)
        
        return chatter
    }
    
    func chatHeaderAvatarImage() -> [String?] {
        var avatars = [event.author?.avatar]
        
        guard let participants = event.attendees else {
            return avatars
        }
        
        let participantAvatars = participants.map{ $0.avatar }
        avatars.append(contentsOf: participantAvatars)
        
        return avatars
    }
}

extension ChatViewController {
    fileprivate func findUserBy(firebaseId: String) -> Profile? {
        if event.author?.firebaseID == firebaseId {
            return event.author
        }
        
        return event.attendees?.filter{ $0.firebaseID == firebaseId }.first
    }
}
