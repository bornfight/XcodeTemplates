//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import Foundation

class ___VARIABLE_sceneName___ {
    
    static var shared = ___VARIABLE_sceneName___()
    
    private init() {}
    
    // Example for String storage
    private var storageAccessToken: String?
    private let accessTokenKey = "access_token"
    var accessToken: String? {
        get {
            storageAccessToken = storageAccessToken ?? UserDefaults.standard.string(forKey: accessTokenKey)
            return storageAccessToken
        }
        set {
            storageAccessToken = newValue
            if newValue != nil {
                UserDefaults.standard.setValue(newValue, forKey: accessTokenKey)
            } else {
                UserDefaults.standard.removeObject(forKey: accessTokenKey)
            }
        }
    }
    
    // Example for Int storage
    private var storageId: Int = 0
    private let userIdKey = "user_id"
    var userId: Int {
        get {
            storageId = UserDefaults.standard.integer(forKey: userIdKey)
            return storageId
        }
        set {
            storageId = newValue
            UserDefaults.standard.set(newValue, forKey: userIdKey)
        }
    }
    
}
