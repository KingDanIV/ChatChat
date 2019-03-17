//
//  ViewController.swift
//  ChatChat
//
//  Created by Daniel Earl on 12/03/2019.
//  Copyright © 2019 Daniel Earl. All rights reserved.
//

import UIKit
import Firebase
import RealmSwift

class ChatViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var chats : Results<Chat>?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        retrieveChats()
        loadChats()
        
    }
    

    //MARK: - Chat Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return chats?.count ?? 1
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath)
        
        if let chat = chats?[indexPath.row] {
        
            cell.textLabel?.text = chat.contact
        
        }
        
        return cell
        
    }
    
    
    
    
    
    
    
    //MARK: - Chat Delegate Methods
    
    
    
    
    
    
    //MARK: - Data Manipulation Methods
    
    func save(chat: Chat) {
        
        do {
            try realm.write {
                realm.add(chat)
            }
        } catch {
            print("Error saving new chat, \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadChats() {
        
        chats = realm.objects(Chat.self)
        
        tableView.reloadData()
        
    }
    
    
    func retrieveChats() {
        
        let chatDB = Database.database().reference().child("Chats")
        
        chatDB.observe(.childAdded) { (snapshot) in
            
            let snapshotValue = snapshot.value as! Dictionary<String,String>
            
            let contact = snapshotValue["Contact"]!
            let sender =  snapshotValue["Sender"]!
            
            let chat = Chat()
            chat.contact = contact
            chat.sender = sender
            
            self.save(chat: chat)
        }
    }
    
    
    
    
    //MARK: - Add New Chat Action
    
    @IBAction func addNewChatPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Start New Chat", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Start Chat", style: .default) { (action) in
            
            let newChat = Chat()
            newChat.contact = textField.text!
            newChat.sender = Auth.auth().currentUser?.email as String!
            
            self.save(chat: newChat)
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Enter Contact Email"
            
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
}

