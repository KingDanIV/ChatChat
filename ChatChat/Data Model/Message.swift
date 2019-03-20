//
//  Message.swift
//  ChatChat
//
//  Created by Daniel Earl on 16/03/2019.
//  Copyright © 2019 Daniel Earl. All rights reserved.
//

import Foundation
import RealmSwift


class Message: Object {
    @objc dynamic var messageBody : String = ""
    @objc dynamic var sender: String = ""
    @objc dynamic var recipient: String = ""
    @objc dynamic var dateSent: Date?
    var parentChat = LinkingObjects(fromType: Chat.self, property: "messages")
}
