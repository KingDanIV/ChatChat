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

class MessagesViewController: UIViewController {
    
    var selectedChat : Chat? {
        didSet {
            loadMessages()
        }
    }
    
    

    
    
    
    //MARK: - Messages Datasource Methods
    
    
    
    
    
    
    //MARK: - Messages Delegate Methods
    
    
    
    
    
    
    //MARK: - Messages Data Manipulation Methods
    
    func loadMessages() {
        
    }
    
}
