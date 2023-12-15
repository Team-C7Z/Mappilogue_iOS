//
//  LoginCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/11/23.
//

import UIKit

protocol LoginDelegate: AnyObject {
    func showSignUpCompletionViewController()
    func showTabBarController()
}

class LoginCoordinator: BaseCoordinator, LoginDelegate {
    let loginViewController = LoginViewController()
    var onSignUpCompletion: (() -> Void)?
    
    override func start() {
        loginViewController.coordinator = self
        navigationController.isNavigationBarHidden = true
        navigationController.pushViewController(loginViewController, animated: false)
    }
    
    func showSignUpCompletionViewController() {
        let coordinator = SignUpCompletionCoordinator(navigationController: self.navigationController)
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }
    
    func showTabBarController() {
        let coordinator = TabBarCoordinator(navigationController: self.navigationController)
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }
}
