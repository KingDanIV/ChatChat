//
//  Chat.swift
//  ChatChat
//
//  Created by Daniel Earl on 16/03/2019.
//  Copyright © 2019 Daniel Earl. All rights reserved.
//

import Foundation
import RealmSwift

class Chat: Object {
    @objc dynamic var contact : String = ""
    @objc dynamic var sender: String = ""
    @objc dynamic var nickname: String = ""
    let messages = List<Message>()
}


