//
//  MessagesViewController.swift
//  ChatChat
//
//  Created by Daniel Earl on 15/03/2019.
//  Copyright © 2019 Daniel Earl. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class MessagesViewController: UIViewController, UITableViewDataSource {
    
    var selectedMessages : Results<Message>?
    
    let realm = try! Realm()
    
    var selectedChat : Chat? {
        didSet {
            loadMessages()
        }
    }
    
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
        
        return selectedMessages?.count ?? 1
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! CustomMessageCell
        
        
        cell.messageBody.text = selectedMessages?[indexPath.row].messageBody ?? "No Messages To Display"
        
        
        return cell
        
    }
    
    
    
    
    //MARK: - Messages Delegate Methods
    
    
    
    
    
    
    //MARK: - Messages Data Manipulation Methods
    
    func loadMessages() {
        
            selectedMessages = selectedChat?.messages.sorted(byKeyPath: "dateSent", ascending: true)
        
    }
    
}
