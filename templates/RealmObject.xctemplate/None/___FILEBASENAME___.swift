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

	convenience init(id: Int) {
		self.init()
		self.id = id
	}

}