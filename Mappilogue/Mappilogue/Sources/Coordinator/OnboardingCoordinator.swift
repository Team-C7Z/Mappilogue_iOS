//
//  OnboardingCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/11/23.
//

import UIKit

protocol OnboardingDelegate: AnyObject {
    func showLoginViewController()
}

class OnboardingCoordinator: BaseCoordinator {
    override func start() {
        let onboardingViewController = OnboardingViewController()
        onboardingViewController.coordinator = self
        navigationController.isNavigationBarHidden = true
        navigationController.pushViewController(onboardingViewController, animated: false)
    }
    
    func showLoginViewController() {
        let coordinator = LoginCoordinator(navigationController: navigationController)
        coordinator.start()
        childCoordinators.append(coordinator)
    }
}
