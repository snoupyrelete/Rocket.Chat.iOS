//
//  Setting.swift
//  Rocket.Chat
//
//  Created by Dylan Robson on 3/24/18.
//  Copyright © 2018 Rocket.Chat. All rights reserved.
//

import RealmSwift

class Setting: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var value: String = ""
    
    override static func primaryKey() -> String {
        return "id"
    }
}
