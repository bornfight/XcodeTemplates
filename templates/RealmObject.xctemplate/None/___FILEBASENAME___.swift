//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import Foundation
import RealmSwift

class ___VARIABLE_sceneName___: Object {
	
	@objc dynamic var id: Int = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }

	convenience init(id: Int) {
		self.init()
		self.id = id
	}

}

class ___VARIABLE_sceneName___Repository: RepositoryType {
    typealias Model = ___VARIABLE_sceneName___
    typealias Id = Int
}
