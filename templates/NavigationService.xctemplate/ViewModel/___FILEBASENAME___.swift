//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import Foundation
import UIKit
import CoconutBits

protocol CoconutFactory {
    func instantiate<T: BaseViewController, V: BaseViewModel, P: BasePresenter>(ViewModelType: V.Type, PresenterType: P.Type, navigationService: NavigationService) -> T
}

extension UIStoryboard: CoconutFactory {
    
    func instantiate<T: BaseViewController, V: BaseViewModel, P: BasePresenter>(ViewModelType: V.Type, PresenterType: P.Type, navigationService: NavigationService) -> T {
        
        var viewModel = ViewModelType.init()
        viewModel.navigationService = navigationService
        
        var presenter = PresenterType.init()
        let viewController: T = instantiateViewController()
        viewController.baseViewModel = viewModel
        viewController.basePresenter = presenter
        presenter.baseViewController = viewController
        
        return viewController
    }
    
}

class ___VARIABLE_sceneName___ {

//    EXAMPLE INIT

//    func initWithWelcomeScreen(window: UIWindow) {
//        let viewController: WelcomeViewController = UIStoryboard.onboarding.instantiate(ViewModelType: WelcomeViewModel.self, PresenterType: WelcomePresenter.self, navigationService: self)
//
//        let navController = RootNavigationController(rootViewController: viewController)
//
//        window.rootViewController = navController
//        rootNavigationController = navController
//    }
    
//    EXAMPLE PUSH
    
//    func pushToRegistrationScreen(navController: UINavigationController?) {
//        let viewController: RegistrationViewController = UIStoryboard.onboarding.instantiate(ViewModelType: RegistrationViewModel.self, PresenterType: RegistrationPresenter.self, navigationService: self))
//
//        navController?.pushViewController(viewController, animated: true)
//    }
}
