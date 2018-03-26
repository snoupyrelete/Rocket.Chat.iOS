//
//  SettingModelMapping.swift
//  Rocket.Chat
//
//  Created by Dylan Robson on 3/24/18.
//  Copyright © 2018 Rocket.Chat. All rights reserved.
//

import SwiftyJSON
import RealmSwift

extension Setting: ModelMappeable {
    func map(_ values: JSON, realm: Realm?) {
        self.id = values["_id"].stringValue
        self.value = values["value"].stringValue
    }
}
