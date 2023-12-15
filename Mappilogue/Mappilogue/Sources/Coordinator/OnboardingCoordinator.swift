//
//  OnboardingCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/11/23.
//

import UIKit

protocol OnboardingDelegate: AnyObject {
    func presentLoginViewController()
}

class OnboardingCoordinator: BaseCoordinator {
    let onboardingViewController = OnboardingViewController()
    
    override func start() {
        onboardingViewController.coordinator = self
        navigationController.pushViewController(onboardingViewController, animated: false)
    }
    
    func presentOnboardingViewController() {
        onboardingViewController.coordinator = self
        onboardingViewController.modalPresentationStyle = .fullScreen
        navigationController.present(onboardingViewController, animated: false)
    }
    
    func presentLoginViewController() {
        onboardingViewController.dismiss(animated: false) {
            let coordinator = LoginCoordinator(navigationController: self.navigationController)
            coordinator.presentLoginViewController()
            self.childCoordinators.append(coordinator)
        }
    }
}
