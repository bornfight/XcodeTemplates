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
    
    let networking = AlamofireNetworking()
    let rootStoryboard = UIStoryboard(name: "Main", bundle: nil)

//    EXAMPLE INIT

//    func initWithWelcomeScreen(window: UIWindow, token: String? = nil) {
//        let viewController: WelcomeViewController = controllerFactory(ViewModelType: WelcomeViewModel.self, PresenterType: WelcomePresenter.self, storyboard: rootStoryboard)
//        viewController.viewModel.token = token
//
//        let navController = RootNavigationController(rootViewController: viewController)
//
//        window.rootViewController = navController
//        rootNavigationController = navController
//    }
    
//    EXAMPLE PUSH
    
//    func pushToRegistrationScreen(navController: UINavigationController?) {
//        let viewController: RegistrationViewController = controllerFactory(ViewModelType: RegistrationViewModel.self, PresenterType: RegistrationPresenter.self, storyboard: rootStoryboard)
//
//        navController?.pushViewController(viewController, animated: true)
//    }
    
    func controllerFactory<T: BaseViewController, V: BaseViewModel, P: BasePresenter>(ViewModelType: V.Type, PresenterType: P.Type, storyboard: UIStoryboard) -> T {
        
        var viewModel = ViewModelType.init()
        viewModel.navigationService = self
        viewModel.networking = networking
        
        var presenter = PresenterType.init()
        let viewController: T = storyboard.instantiateViewController()
        viewController.baseViewModel = viewModel
        viewController.basePresenter = presenter
        presenter.baseViewController = viewController
        
        return viewController
    }
}
