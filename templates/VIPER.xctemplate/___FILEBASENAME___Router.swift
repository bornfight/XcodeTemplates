//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import Foundation

protocol ___VARIABLE_sceneName___RouterInput {
}

class ___VARIABLE_sceneName___Router: ___VARIABLE_sceneName___RouterInput { 

    weak var viewController: ___VARIABLE_sceneName___ViewController!

    enum Storyboards: String {

        var instance: UIStoryboard {
            return UIStoryboard(name: rawValue, bundle: nil)
        }
    }
}
