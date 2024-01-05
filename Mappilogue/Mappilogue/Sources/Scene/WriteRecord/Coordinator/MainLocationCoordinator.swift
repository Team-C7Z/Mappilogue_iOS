//
//  MainLocationCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/24/23.
//

import Foundation

protocol MainLocationDelegate: AnyObject {
    func showMapMainLocationViewController()
    func popViewController()
}

class MainLocationCoordinator: AppCoordinator, MainLocationDelegate {
    override func start() { 
        let mainLocationViewController = MainLocationViewController()
        mainLocationViewController.coordinator = self
        navigationController.pushViewController(mainLocationViewController, animated: false)
    }
    
    func showMapMainLocationViewController() {
        let coordinator =
        MapMainLocationCoordinator(navigationController: navigationController)
        coordinator.start()
        childCoordinators.append(coordinator)
    }
    
    func showMainLocationAlertViewController() {
        let coordinator = MainLocationAlertCoordinator(navigationController: navigationController)
        coordinator.start()
        childCoordinators.append(coordinator)
    }

    func popViewController() {
        childDidFinish(self)
        navigationController.popViewController(animated: false)
    }
}
