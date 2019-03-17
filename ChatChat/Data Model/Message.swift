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
    var parentChat = LinkingObjects(fromType: Chat.self, property: "messages")
}
