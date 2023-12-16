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
    override func start() {
        let loginViewController = LoginViewController()
        loginViewController.coordinator = self
        navigationController.pushViewController(loginViewController, animated: false)
    }
    
    func showSignUpCompletionViewController() {
        let coordinator = SignUpCompletionCoordinator(navigationController: navigationController)
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }
    
    func showTabBarController() {
        let tabBarController = UITabBarController()
        let coordinator = TabBarCoordinator(tabBarController: tabBarController, navigationController: navigationController)
        childCoordinators.append(coordinator)
        coordinator.start()
   
    }
}
