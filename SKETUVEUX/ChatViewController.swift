//
//  ChatViewController.swift
//  SKETUVEUX
//
//  Created by Jovan on 28/10/2022.
//

import UIKit
import MessageKit
import Alamofire

public struct Sender: SenderType {
    public var senderId: String
    public var displayName: String
}

struct Message: MessageType {
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
}

struct MyResult: Decodable{
    let gender: String
    let probability: Int
    
}



let sender = Sender(senderId: "any_unique_id", displayName: "Steven")
var messages: [Message] = []

class ChatViewController:  MessagesViewController {
    
    let otherUser = Sender(senderId: "other", displayName: "Yannick")
    let vc = JTJController()
    var gender: String  = ""
    let urlapi = "https://api.genderize.io/?name=Yannick"
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        messages.append(Message(sender: currentSender, messageId: "1", sentDate: Date().addingTimeInterval(-86400), kind: .text("Hello!")))
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
        AF.request(urlapi,method: .get).validate().responseDecodable(of: MyResult.self) { response in
            if let responseVal = response.value {
                print(responseVal)
            }
        }
        
        self.messagesCollectionView.reloadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
       super.viewDidDisappear(animated)
       messages = []
     }
    
    func isLastSectionVisible() -> Bool {
      guard !messages.isEmpty else { return false }
      let lastIndexPath = IndexPath(item: 0, section: messages.count - 1)
      return messagesCollectionView.indexPathsForVisibleItems.contains(lastIndexPath)
    }
    
    
}

extension ChatViewController: MessagesDataSource {

    var currentSender: SenderType {
        return Sender(senderId: "toto", displayName: "Steven")
    }

    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }

    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
}

extension ChatViewController: MessagesDisplayDelegate, MessagesLayoutDelegate {}

