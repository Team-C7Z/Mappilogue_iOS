//
//  HomeCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/16/23.
//

import UIKit

protocol HomeDelegate: AnyObject {
}

class HomeCoordinator: Coordinator, HomeDelegate {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let homeViewController = HomeViewController()
        navigationController.pushViewController(homeViewController, animated: false)
    }
    
    func showLoginViewController() {
        let coordinator = LoginCoordinator(navigationController: self.navigationController)
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }
}
