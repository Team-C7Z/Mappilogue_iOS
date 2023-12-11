//
//  LoginCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/11/23.
//

import UIKit

protocol LoginDelegate: AnyObject {
    func presentTabBarController()
}

class LoginCoordinator: BaseCoordinator {
    var onSignUpCompletion: (() -> Void)?
    
    override func start() {
        let loginViewController = LoginViewController()
        loginViewController.coordinator = self
        navigationController.isNavigationBarHidden = true
        navigationController.pushViewController(loginViewController, animated: false)
    }
    
    func showTabBarController() {
        let coordinator = TabBarCoordinator(navigationController: navigationController)
        coordinator.start()
        childCoordinators.append(coordinator)
    }
}
