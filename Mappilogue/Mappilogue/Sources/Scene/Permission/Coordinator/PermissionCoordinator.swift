//
//  PermissionCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/11/23.
//

import UIKit

protocol PermissionDelegate: AnyObject {
    func showSelectPermissionViewController()
}

class PermissionCoordinator: BaseCoordinator, PermissionDelegate {
    override func start() {
        let permissionViewController = PermissionViewController()
        permissionViewController.coordinator = self
        navigationController.pushViewController(permissionViewController, animated: false)
    }
    
    func showSelectPermissionViewController() {
        let coordinator = SelectPermissionCoordinator(navigationController: navigationController)
        coordinator.start()
        childDidFinish(self)
        childCoordinators.append(coordinator)
    }
}
