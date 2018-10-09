//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import Foundation
import RealmSwift

protocol Mockable {
    
    associatedtype T = Self
    
    static func mock() -> T
    
}

extension Object: Mockable {
    
    static func mock() -> T {
        let group = self.init()
        group.objectSchema.properties.forEach { (prop) in
            switch prop.type {
            case .bool:
                group.setValue(false, forKey: prop.name)
            case .int:
                group.setValue(Int.random(in: Int.min..<Int.max), forKey: prop.name)
            case .double:
                group.setValue(1.5, forKey: prop.name)
            case .float:
                group.setValue(2.5, forKey: prop.name)
            case .data:
                group.setValue(Data(repeating: 4, count: 10), forKey: prop.name)
            case .date:
                group.setValue(Date(), forKey: prop.name)
            case .string:
                group.setValue("Mocked String", forKey: prop.name)
            default:
                break
            }
        }
        return group
    }
}

class ___VARIABLE_sceneName___ {
    
    let realm: Realm
    let notDeletedPredicate = NSPredicate(format: "deleted == 0")
    let deletedPredicate = NSPredicate(format: "deleted == 1")
    
    init() {
        realm = try! Realm()
    }
    
    static func configureRealm() {
        // Realm configuration
        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            
            schemaVersion: 13,
            
            
            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            migrationBlock: { migration, oldSchemaVersion in
                // We haven’t migrated anything yet, so oldSchemaVersion == 0
                if (oldSchemaVersion < 0) {
                    // Nothing to do!
                    // Realm will automatically detect new properties and removed properties
                    // And will update the schema on disk automatically
                }
        })
        
        // Tell Realm to use this new configuration object for the default Realm
        Realm.Configuration.defaultConfiguration = config
    }
    
}
