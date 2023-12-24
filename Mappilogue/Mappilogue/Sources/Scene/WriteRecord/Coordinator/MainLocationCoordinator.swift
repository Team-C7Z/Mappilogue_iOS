//
//  MainLocationCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/24/23.
//

import Foundation

protocol MainLocationDelegate: AnyObject {
    func showMapMainLocationController()
    func popViewController()
}

class MainLocationCoordinator: AppCoordinator, MainLocationDelegate {
    override func start() { 
        let mainLocationViewController = MainLocationViewController()
        mainLocationViewController.coordinator = self
        navigationController.pushViewController(mainLocationViewController, animated: false)
    }
    
    func showMapMainLocationController() {
        let coordinator =
        MapMainLocationCoordinator(navigationController: self.navigationController)
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }

    func popViewController() {
        navigationController.popViewController(animated: false)
    }
}
