//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import Foundation
import RealmSwift

final class ___VARIABLE_sceneName___: Object, Parsable {
	
	@objc dynamic var id: Int = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }

	enum CodingKeys: String, CodingKey {
		case id
	}

	required convenience init(from decoder: Decoder) throws {
		self.init()
		let container = try decoder.container(keyedBy: CodingKeys.self)
		id = (try? container.decode(Int.self, forKey: .id)) ?? 0
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
