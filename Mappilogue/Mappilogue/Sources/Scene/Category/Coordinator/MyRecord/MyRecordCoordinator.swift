//
//  MyRecordCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/24/23.
//

import Foundation

protocol MyRecordDelegate: AnyObject {
    func popViewController()
}

class MyRecordCoordinator: AppCoordinator, MyRecordDelegate {
    override func start() { }
    
    func showMyRecordViewController(categoryId: Int, categoryName: String) {
        let myRecordViewController = MyRecordViewController()
        myRecordViewController.categoryId = categoryId
        myRecordViewController.categoryName = categoryName
        myRecordViewController.coordinator = self
        navigationController.pushViewController(myRecordViewController, animated: false)
    }
    
    func showContentViewController() {
        let coordinator = ContentCoordinator(navigationController: self.navigationController)
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }
    
    func showMyRecordListViewController() {
        let coordinator = MyRecordListCoordinator(navigationController: self.navigationController)
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }
    
    func showEditCategoryViewController(categoryId: Int, categoryName: String) {
        let coordinator = EditCategoryCoordinator(navigationController: navigationController)
        coordinator.showEditCategoryViewController(categoryId: categoryId, categoryName: categoryName)
        self.childCoordinators.append(coordinator)
    }
    
    func popViewController() {
        childDidFinish(self)
        navigationController.popViewController(animated: false)
    }
}
