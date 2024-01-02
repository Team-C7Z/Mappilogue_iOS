//
//  BaseCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/11/23.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    func start()
}

extension Coordinator {
    func childDidFinish(_ coordinator: Coordinator) {
        for (index, child) in childCoordinators.enumerated() where child === coordinator {
            childCoordinators.remove(at: index)
            break
        }
    }
}

class BaseCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {}
}
