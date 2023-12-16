//
//  SignUpCompletionCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/15/23.
//

import UIKit

protocol SignUpCompletionDelegate: AnyObject {
    func presentTabBarController()
}

class SignUpCompletionCoordinator: BaseCoordinator, SignUpCompletionDelegate {
    override func start() {
        presentSignUpController()
    }
    
    func presentSignUpController() {
        let signUpCompletionController = SignUpCompletionViewController()
        signUpCompletionController.coordinator = self
        navigationController.pushViewController(signUpCompletionController, animated: false)
    }
    
    func presentTabBarController() {
        let coordinator = TabBarCoordinator(navigationController: self.navigationController)
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }
}
