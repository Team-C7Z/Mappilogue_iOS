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
    let signUpCompletionController = SignUpCompletionViewController()
    
    override func start() {
        presentSignUpController()
    }
    
    func presentSignUpController() {
        signUpCompletionController.coordinator = self
        signUpCompletionController.modalPresentationStyle = .fullScreen
        navigationController.present(signUpCompletionController, animated: false)
    }
    
    func presentTabBarController() {
        signUpCompletionController.dismiss(animated: false) {
            let coordinator = TabBarCoordinator(navigationController: self.navigationController)
            coordinator.start()
            self.childCoordinators.append(coordinator)
        }
    }
}
