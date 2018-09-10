//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import Foundation

class ___VARIABLE_sceneName___Configurator { 

    // MARK: - Object Lifecycle
    static let sharedInstance = ___VARIABLE_sceneName___Configurator()
    
    // MARK: - Configuration
    func configure(_ viewController: ___VARIABLE_sceneName___ViewController) {
        let router = ___VARIABLE_sceneName___Router()
        router.viewController = viewController

        let presenter = ___VARIABLE_sceneName___Presenter()
        presenter.output = viewController

        let interactor = ___VARIABLE_sceneName___Interactor()
        interactor.output = presenter

        viewController.output = interactor
        viewController.router = router
    }
}
