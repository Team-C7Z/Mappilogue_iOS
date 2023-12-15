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
    let loginViewController = LoginViewController()
    var onSignUpCompletion: (() -> Void)?
    
    override func start() {
        loginViewController.coordinator = self
        navigationController.pushViewController(loginViewController, animated: false)
    }
    
    func presentLoginViewController() {
        loginViewController.coordinator = self
        loginViewController.modalPresentationStyle = .fullScreen
        navigationController.present(loginViewController, animated: false)
    }
    
    func showTabBarController() {
        let coordinator = TabBarCoordinator(navigationController: navigationController)
        coordinator.start()
        childCoordinators.append(coordinator)
    }
}
