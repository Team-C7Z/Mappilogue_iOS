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

class OnboardingCoordinator: BaseCoordinator, OnboardingDelegate {
    let onboardingViewController = OnboardingViewController()
    
    override func start() {
        onboardingViewController.coordinator = self
        navigationController.isNavigationBarHidden = true
        navigationController.pushViewController(onboardingViewController, animated: false)
    }
    
    func showLoginViewController() {
        let coordinator = LoginCoordinator(navigationController: self.navigationController)
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }
}
