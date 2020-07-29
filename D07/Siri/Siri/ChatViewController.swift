//
//  ChatViewController.swift
//  Siri
//
//  Created by  Vladyslav Fil on 10/8/19.
//  Copyright © 2019 Vladyslav FIL. All rights reserved.
//

import UIKit
import JSQMessagesViewController
import ForecastIO
import RecastAI
import CoreLocation

class ChatViewController: JSQMessagesViewController {

    var messages = [JSQMessage]()
    var recastAIBot: RecastAIClient?
    var darkSkyBot: DarkSkyClient?
    let errorMessage: String = "Sorry, but I don't understand you..."
    let botName: String = "Recast"
    let botId: String = "777"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.recastAIBot = RecastAIClient(token: "cad015d393a344ae67395b3055ab91c4", language: "en")
        self.darkSkyBot = DarkSkyClient(apiKey: "01bd9a9eafb3d1d71c307bf67944a47e")
        self.darkSkyBot?.language = .english
        
        senderId = "555"
        senderDisplayName = "vfil"
        inputToolbar.contentView.leftBarButtonItem = nil
        collectionView.collectionViewLayout.incomingAvatarViewSize = CGSize.zero
        collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSize.zero
        
        messages.append(JSQMessage(senderId: senderId, displayName: senderDisplayName, text: "Talk with me!"))
        messages.append(JSQMessage(senderId: botId, displayName: botName, text: "Talk with me!"))
    }
    
    lazy var outgoingBubble: JSQMessagesBubbleImage = {
        return JSQMessagesBubbleImageFactory()!.outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleGreen())
    }()
    
    lazy var incomingBubble: JSQMessagesBubbleImage = {
        return JSQMessagesBubbleImageFactory()!.outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleRed())
    }()
    
    
}

//Chat handling extension
extension ChatViewController {
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        return messages[indexPath.item].senderId == senderId ? outgoingBubble : incomingBubble
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAt indexPath: IndexPath!) -> NSAttributedString! {
        return messages[indexPath.item].senderId == senderId ? nil : NSAttributedString(string: messages[indexPath.item].senderDisplayName)
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAt indexPath: IndexPath!) -> CGFloat {
        return messages[indexPath.item].senderId == senderId ? 0 : 15
    }
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!)
    {
        finishSendingMessage()
        if let message = JSQMessage(senderId: senderId, displayName: senderDisplayName, text: text) {
            messages.append(message)
            self.recastAIBot?.textRequest(text, successHandler: setSuccessResponse, failureHandle: setFailureResponse)
            finishReceivingMessage()
        }
    }
}

//Weather handling extension
extension ChatViewController {
    func setSuccessResponse(_ response: Response) {
        if let location = response.get(entity: "location") {
            if let lat = location["lat"] as? CLLocationDegrees, let lng = location["lng"] as? CLLocationDegrees {
                let myLoc = CLLocationCoordinate2D(latitude: lat, longitude: lng)
                self.darkSkyBot?.getForecast(location: myLoc, completion: { (result) in
                    switch result {
                    case .success(let currentForcast, _):
                        DispatchQueue.main.async {
                            self.addBotMessage(text: (currentForcast.currently?.summary)!)
                        }
                    case .failure(_):
                        DispatchQueue.main.async {
                            self.addBotMessage(text: self.errorMessage)
                        }
                    }
                })
            }
        }
        else {
            addBotMessage(text: errorMessage)
        }
    }
    
    func setFailureResponse(_ error: Error) {
        addBotMessage(text: errorMessage)
    }

    func addBotMessage(text: String) {
        self.messages.append(JSQMessage(senderId: botId, displayName: botName, text: text))
        finishSendingMessage()
    }
}
