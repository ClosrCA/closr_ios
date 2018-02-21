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

class ChatViewController: UIViewController {

    lazy var messageViewController: MessageViewController = {
        let controller = MessageViewController()
        // TODO: replace with event id
        controller.channelID            = "1"
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
        guard let hostName = event.author?.name else {
            return [""]
        }
        
        var chatter = [hostName]
        let participants = event.participants.map{ $0.name ?? "" }
        
        chatter.append(contentsOf: participants)
        
        return chatter
    }
    
    func chatHeaderAvatarImage() -> [String?] {
        var avatars = [event.author?.avatar]
        
        let participantAvatars = event.participants.map{ $0.avatar }
        avatars.append(contentsOf: participantAvatars)
        
        return avatars
    }
}

extension ChatViewController {
    fileprivate func findUserBy(firebaseId: String) -> User? {
        if event.author?.firbaseID == firebaseId {
            return event.author
        }
        
        return event.participants.filter{ $0.firbaseID == firebaseId }.first
    }
}
