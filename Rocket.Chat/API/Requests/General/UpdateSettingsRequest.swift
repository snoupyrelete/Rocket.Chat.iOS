//
//  UpdateSettingsRequest.swift
//  Rocket.Chat
//
//  Created by Dylan Robson on 3/25/18.
//  Copyright © 2018 Rocket.Chat. All rights reserved.
//
//  DOCS: https://rocket.chat/docs/developer-guides/rest-api/settings/update/

import SwiftyJSON

typealias UpdateSettingsResult = APIResult<UpdateSettingsRequest>

class UpdateSettingsRequest: APIRequest {
    let requiredVersion = Version(0, 60, 0)
    
    let method: HTTPMethod = .post
    let path = "/api/v1/settings/:_id"
    
    let id: String
    let value: String
    
    init(id: String, value: String) {
        self.id = id
        self.value = value
    }
    func body() -> Data? {
        let body = JSON([
            "_id": id,
            "value": value
        ])
        return body.rawString()?.data(using: .utf8)
    }
}

extension APIResult where T == UpdateSettingsRequest {
    var success: Bool? {
        guard let rawSuccess = raw?["success"] else { return nil }
        return rawSuccess.boolValue
    }
}
