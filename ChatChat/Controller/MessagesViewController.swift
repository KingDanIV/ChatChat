//
//  MessagesViewController.swift
//  ChatChat
//
//  Created by Daniel Earl on 15/03/2019.
//  Copyright © 2019 Daniel Earl. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class MessagesViewController: UIViewController, UITableViewDataSource {
    
    var selectedMessages = [Message]()
    
    var selectedChat : Chat? {
        didSet {
            loadMessages()
        }
    }
    
    
    //MARK - Link Up IB
    @IBOutlet var messageTableView: UITableView!
    
    
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        messageTableView.dataSource = self
        
        
        //TODO: Register your MessageCell.xib file here:
        messageTableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "customMessageCell")
        
        messageTableView.separatorStyle = .none
        
    }
    

    
    
    
    //MARK: - Messages Datasource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return selectedMessages.count
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! CustomMessageCell
        
        let message = selectedMessages[indexPath.row]
        
        
        cell.messageBody.text = message.messageBody
        cell.senderUsername.text = message.sender
        
        
        return cell
        
    }
    
    
    
    
    //MARK: - Messages Delegate Methods
    
    
    
    
    
    
    //MARK: - Messages Data Manipulation Methods
    
    func loadMessages() {
        
//            selectedMessages = selectedChat?.messages.sorted(byKeyPath: "dateSent", ascending: true)
        
        let messageDB = Database.database().reference().child("Messages")
        
        messageDB.observe(.childAdded) { (snapshot) in
            
            let snapshotValue = snapshot.value as! Dictionary<String,Any>
            
            let text = snapshotValue["MessageBody"] as! String
            let sender = snapshotValue["Sender"]! as! String
            let recipient = snapshotValue["Recipient"]! as! String
            let dateSent = snapshotValue["DateSent"]! as! Date
            
            let message = Message()
            message.messageBody = text
            message.sender = sender
            message.recipient = recipient
            message.dateSent = dateSent
            
            
        }
        
    }
    
}
