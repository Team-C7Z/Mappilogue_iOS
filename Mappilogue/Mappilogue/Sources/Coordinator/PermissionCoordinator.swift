//
//  PermissionCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/11/23.
//

import UIKit

protocol PermissionDelegate: AnyObject {
    func presentOnboardingViewController()
}

class PermissionCoordinator: BaseCoordinator, PermissionDelegate {
    override func start() {
        let permissionViewController = PermissionViewController()
        permissionViewController.coordinator = self
        navigationController.pushViewController(permissionViewController, animated: false)
    }
    
    func presentOnboardingViewController() {
        let coordinator = OnboardingCoordinator(navigationController: navigationController)
        coordinator.presentOnboardingViewController()
        childCoordinators.append(coordinator)
    }
}
