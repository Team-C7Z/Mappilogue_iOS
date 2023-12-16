//
//  SelectPermissionCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/16/23.
//

import Foundation

protocol SelectPermissionDelegate: AnyObject {
    func showOnboardingViewController()
}

class SelectPermissionCoordinator: BaseCoordinator, SelectPermissionDelegate {
    override func start() {
        let selectPermissionViewController = SelectPermissionViewController()
        selectPermissionViewController.coordinator = self
        navigationController.isNavigationBarHidden = true
        navigationController.pushViewController(selectPermissionViewController, animated: false)
    }
    
    func showOnboardingViewController() {
        let coordinator = OnboardingCoordinator(navigationController: navigationController)
        coordinator.start()
        childCoordinators.append(coordinator)
    }
}
