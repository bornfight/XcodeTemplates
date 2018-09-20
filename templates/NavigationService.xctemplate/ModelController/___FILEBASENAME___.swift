//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import Foundation
import UIKit
import EssentialPod

class ___VARIABLE_sceneName___ {
    
    let rootStoryboard = UIStoryboard(name: "Main", bundle: nil)

//    EXAMPLE INIT

//    func initWithWelcomeScreen(window: UIWindow, token: String? = nil) {
//        let viewController: WelcomeViewController = controllerFactory(ModelControllerType: WelcomeModelController.self, PresenterType: WelcomePresenter.self, storyboard: rootStoryboard)
//        viewController.viewModel.token = token
//
//        let navController = RootNavigationController(rootViewController: viewController)
//
//        window.rootViewController = navController
//        rootNavigationController = navController
//    }
    
//    EXAMPLE PUSH
    
//    func pushToRegistrationScreen(navController: UINavigationController?) {
//        let viewController: RegistrationViewController = controllerFactory(ModelControllerType: RegistrationModelController.self, PresenterType: RegistrationPresenter.self, storyboard: rootStoryboard)
//
//        navController?.pushViewController(viewController, animated: true)
//    }
    
    func controllerFactory<T: BaseViewController, V: BaseModelController, P: BasePresenter>(ModelControllerType: V.Type, PresenterType: P.Type, storyboard: UIStoryboard) -> T {
        
        var modelController = ModelControllerType.init()
        modelController.navigationService = self
        
        var presenter = PresenterType.init()
        let viewController: T = storyboard.instantiateViewController()
        viewController.BaseModelController = modelController
        viewController.basePresenter = presenter
        presenter.baseViewController = viewController
        
        return viewController
    }
}
