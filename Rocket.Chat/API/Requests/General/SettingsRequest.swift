//
//  SettingsRequest.swift
//  Rocket.Chat
//
//  Created by Dylan Robson on 3/24/18.
//  Copyright © 2018 Rocket.Chat. All rights reserved.
//
//  DOCS: https://rocket.chat/docs/developer-guides/rest-api/settings/get/ & https://rocket.chat/docs/developer-guides/rest-api/settings/public/

import SwiftyJSON

typealias SettingsResult = APIResult<SettingsRequest>

class SettingsRequest: APIRequest {
    let path = "/api/v1/settings"
    //let path = "/api/v1/settings.public"
    let requiredVersion = Version(0, 60, 0)
}

extension APIResult where T == SettingsRequest {
    var settings: [Setting]? {
        return raw?["settings"].arrayValue.map {
            let setting = Setting()
            setting.map($0, realm: nil)
            return setting
            }.flatMap { $0 }
    }
}
