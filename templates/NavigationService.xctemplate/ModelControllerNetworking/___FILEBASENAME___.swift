//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

protocol CoconutFactory {
    func controllerFactory<T: BaseViewController, V: BaseModelController, P: BasePresenter>(ModelControllerType: V.Type, PresenterType: P.Type, navigationService: NavigationService) -> T
}

extension UIStoryboard: CoconutFactory {
    
    func controllerFactory<T: BaseViewController, V: BaseModelController, P: BasePresenter>(ModelControllerType: V.Type, PresenterType: P.Type, navigationService: NavigationService) -> T {
        
        var modelController = ModelControllerType.init()
        modelController.navigationService = navigationService
        modelController.networking = navigationService.networking
        
        var presenter = PresenterType.init()
        let viewController: T = instantiateViewController()
        viewController.baseModelController = modelController
        viewController.basePresenter = presenter
        presenter.baseViewController = viewController
        
        return viewController
    }
    
}

class ___VARIABLE_sceneName___ {
    
    let networking = AlamofireNetworking()
    
    //    EXAMPLE INIT
    
    //    func initWithWelcomeScreen(window: UIWindow) {
    //        let viewController: WelcomeViewController = UIStoryboard.onboarding.controllerFactory(ModelControllerType: WelcomeModelController.self, PresenterType: WelcomePresenter.self, navigationService: self)
    //
    //        let navController = RootNavigationController(rootViewController: viewController)
    //
    //        window.rootViewController = navController
    //        rootNavigationController = navController
    //    }
    
    //    EXAMPLE PUSH
    
    //    func pushToRegistrationScreen(navController: UINavigationController?) {
    //        let viewController: RegistrationViewController = UIStoryboard.onboarding.controllerFactory(ModelControllerType: RegistrationModelController.self, PresenterType: RegistrationPresenter.self, navigationService: self))
    //
    //        navController?.pushViewController(viewController, animated: true)
    //    }
}
