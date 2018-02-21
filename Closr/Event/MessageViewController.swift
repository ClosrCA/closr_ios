//
//  MessageViewController.swift
//  Closr
//
//  Created by ZHITAO TIAN on 2017-08-26.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit
import Firebase
import JSQMessagesViewController

protocol MessageViewControllerDelegate: class {
    func chatAvatar(for firebaseId: String) -> ChatAvatar
}

class MessageViewController: JSQMessagesViewController {

    var channelID: String? {
        didSet {
            guard let id = channelID else {
                return
            }
            
            messageReference = channelReference.child(id).child("messages")
        }
    }
    
    fileprivate lazy var channelReference: DatabaseReference = Database.database().reference().child("channels")
    
    weak var delegate: MessageViewControllerDelegate?
    
    fileprivate var messageReference: DatabaseReference?
    fileprivate var messageRefHandler: DatabaseHandle?
    fileprivate var messages = [JSQMessage]()
    
    fileprivate lazy var outgoingBubble: JSQMessagesBubbleImage = {
        let bubbleImageFactory = JSQMessagesBubbleImageFactory()
        return bubbleImageFactory!.outgoingMessagesBubbleImage(with: AppColor.background_gray)
    }()
    
    fileprivate lazy var incomingBubble: JSQMessagesBubbleImage = {
        let bubbleImageFactory = JSQMessagesBubbleImageFactory()
        return bubbleImageFactory!.incomingMessagesBubbleImage(with: AppColor.brand)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configChatView()
        
        observeMessages()
    }
    
    fileprivate func configChatView() {
        inputToolbar.contentView.leftBarButtonItem = nil
        
        collectionView.collectionViewLayout.incomingAvatarViewSize = AppSizeMetric.chatAvatarSize
        collectionView.collectionViewLayout.outgoingAvatarViewSize = AppSizeMetric.chatAvatarSize
    }
    
    fileprivate func observeMessages() {
        // TODO: pagination
        let messageQuery = messageReference?.queryLimited(toLast: 25)
        
        messageRefHandler = messageQuery?.observe(.childAdded, with: { [weak self] (snapshot) in
            guard let weakSelf = self else {
                return
            }
            
            guard let messageData = snapshot.value as? [String: String] else {
                return
            }
            
            guard let id = messageData["senderId"], let name = messageData["displayName"], let text = messageData["text"] else {
                return
            }
            
            weakSelf.addMessage(with: id, name: name, text: text)
            
            weakSelf.finishReceivingMessage()
        })
    }
    
    fileprivate func addMessage(with id: String, name: String, text: String) {
        if let message = JSQMessage(senderId: id, displayName: name, text: text) {
            messages.append(message)
        }
    }
    
    deinit {
        if let handler = messageRefHandler {
            messageReference?.removeObserver(withHandle: handler)
        }
    }
}

extension MessageViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        let message = messages[indexPath.item]
        
        if message.senderId == senderId {
            return outgoingBubble
        }
        
        return incomingBubble
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell    = super.collectionView(collectionView, cellForItemAt: indexPath) as! JSQMessagesCollectionViewCell
        let message = messages[indexPath.item]
        
        cell.textView.textColor = message.senderId == senderId ? AppColor.text_dark : AppColor.text_light_gray
        
        return cell
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        // TODO create ChatAvatar from User
        if let senderId = messages[indexPath.item].senderId {
            return delegate?.chatAvatar(for: senderId)
        }
        
        return nil
    }
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        let itemRef = messageReference?.childByAutoId()
        let messageItem = [
            "senderId": senderId,
            "displayName": senderDisplayName,
            "text": text
        ]
        
        itemRef?.setValue(messageItem)
        
        JSQSystemSoundPlayer.jsq_playMessageSentSound()
        
        finishSendingMessage()
    }
}
