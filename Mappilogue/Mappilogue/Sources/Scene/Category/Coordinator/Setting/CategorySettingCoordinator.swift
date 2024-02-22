//
//  CategorySettingCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/24/23.
//

import Foundation

protocol CategorySettingDelegate: AnyObject {
    func showInputModalViewController()
    func popViewController()
}

class CategorySettingCoordinator: CategorySettingDelegate {
//    override func start() {
//        let categorySettingController = CategorySettingViewController()
//        categorySettingController.hidesBottomBarWhenPushed = true
//        categorySettingController.coordinator = self
//        navigationController.pushViewController(categorySettingController, animated: false)
//    }
    
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
