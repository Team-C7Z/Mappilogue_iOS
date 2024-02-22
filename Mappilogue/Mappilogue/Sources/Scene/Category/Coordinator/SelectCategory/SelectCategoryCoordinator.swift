//
//  SelectCategoryCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/24/23.
//

import Foundation

protocol SelectCategoryDelegate: AnyObject {
    func popViewController()
}

class SelectCategoryCoordinator: SelectCategoryDelegate {
    func start() {
        let selectCategoryViewController = SelectCategoryViewController()
        selectCategoryViewController.coordinator = self
       // navigationController.pushViewController(selectCategoryViewController, animated: false)
    }
    
    func showInputModalViewController() {
//        let coordinator = InputModalCoordinator(navigationController: self.navigationController)
//        coordinator.start()
//        self.childCoordinators.append(coordinator)
    }
    
    func popViewController() {
//        childDidFinish(self)
//        navigationController.popViewController(animated: false)
    }
}
