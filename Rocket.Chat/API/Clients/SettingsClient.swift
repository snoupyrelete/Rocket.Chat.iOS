//
//  SettingsClient.swift
//  Rocket.Chat
//
//  Created by Dylan Robson on 3/24/18.
//  Copyright © 2018 Rocket.Chat. All rights reserved.
//

import RealmSwift

struct SettingsClient: APIClient {
    let api: AnyAPIFetcher
//    var aSettings: [Setting]?
    
    func fetchSettings(realm: Realm? = Realm.shared) -> Results<Setting>? {
        let request = SettingsRequest()
        api.fetch(request, options: .paginated(count: 0, offset: 0), sessionDelegate: nil, succeeded: { result in
            DispatchQueue.main.async {
                result.settings?.forEach { setting in
                    try? realm?.write {
                        // Can use realm.add if pk set for Setting.model
                        realm?.add(setting, update: true)
                    }
                }
            }
        }, errored: nil)

        // Settings -> 630, Settings.public -> 308 Results
        guard let settings = realm?.objects(Setting.self).filter("id CONTAINS 'theme' OR id == 'css'") else { return nil }
        let c: Int = settings.count
            //.filter("id BEGINSWITH %@", "theme")
            // Settings returns "id: 'css'" - Settings.public does not
        
        return settings
    }
    
    @discardableResult
    func updateSetting(_ setting: Setting, realm: Realm? = Realm.shared) -> Bool {

        let id = setting.id
        // will never return false? nonoptional
        if id.isEmpty { return false }
        
        let request = UpdateSettingsRequest(id: id, value: setting.value)
        api.fetch(request, succeeded: { response in
            guard let success = response.success else { return Alert.defaultError.present() }
            DispatchQueue.main.async {
                try? realm?.write {
                    realm?.add(setting, update: true)
                }
                //MessageTextCacheManager.shared.update(for: message)
            }
            
        }, errored: { _ in Alert.defaultError.present() })
        
        return true
    }
}

