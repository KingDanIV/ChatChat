//
//  ViewController.swift
//  ChatChat
//
//  Created by Daniel Earl on 12/03/2019.
//  Copyright © 2019 Daniel Earl. All rights reserved.
//

import UIKit
import Firebase


class ChatViewController: UITableViewController {
    
    var chats = [Chat]()
    
    
    var fakeChat = ["First Chat","Second Chat","Third Chat"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let currentUser = Contact()
//        currentUser.email = Auth.auth().currentUser?.email as String!
//        currentUser.nickname = "Me"
    
        
        retrieveChats()
        
        
    }
    

    //MARK: - Chat Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return chats.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath)
        
        cell.textLabel?.text = chats[indexPath.row].contact
        
        return cell
        
    }
    
    
    
    
    //MARK: - Chat Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToMessages", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! MessagesViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedChat = chats[indexPath.row]
        }
    }
    
    
    
    
    
    
    //MARK: - Data Manipulation Methods
    
//    func save(chat: Chat) {
//
//        do {
//            try realm.write {
//                realm.add(chat)
//            }
//        } catch {
//            print("Error saving new chat, \(error)")
//        }
//
//        self.tableView.reloadData()
//    }
//
//    func loadChats() {
//
//        chats = realm.objects(Chat.self)
//
//        print("load chats successful")
//
//        tableView.reloadData()
//
//        print("tableView reloaded")
//
//    }
    
    
    func retrieveChats() {
        
        let chatDB = Database.database().reference().child("Chats")
        
        chatDB.observe(.childAdded) { (snapshot) in
            
            let snapshotValue = snapshot.value as! Dictionary<String,String>
            
            let contact = snapshotValue["Contact"]!
            let sender =  snapshotValue["Sender"]!
            
            let newChat = Chat()
            newChat.contact = contact
            newChat.sender = sender
            
            if let nickname = snapshotValue["Nickname"] {
                newChat.nickname = nickname
            }
            
            self.chats.append(newChat)
            
            print(newChat.contact)
            print(newChat.sender)
            print(self.chats.count)
            
            self.tableView.reloadData()
        }
        
        
    }
    
    
    
    
    //MARK: - Add New Chat Action
    
    @IBAction func addNewChatPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Start New Chat", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Start Chat", style: .default) { (action) in
            
            let contactDB = Database.database().reference().child("Chats")
            
            let contactDict = [ "Contact": textField.text!,
                                "Sender": Auth.auth().currentUser?.email as String!]
            
            
            contactDB.childByAutoId().setValue(contactDict, withCompletionBlock: {
                (error, reference) in
                
                if error != nil {
                    print(error!)
                } else {
                    print("New chat added successfully!")
                }
                
            })
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Enter Contact Email"
            
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
}

