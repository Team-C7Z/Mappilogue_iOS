//
//  MyRecordListCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/24/23.
//

import Foundation

protocol MyRecordListDelegate: AnyObject {
    func showMyRecordViewController(cateogryId: Int, categoryName: String)
    func popViewController()
}

class MyRecordListCoordinator: AppCoordinator, MyRecordListDelegate {
    override func start() {
        let myRecordListViewController = MyRecordListViewController()
        myRecordListViewController.hidesBottomBarWhenPushed = true
        myRecordListViewController.coordinator = self
        navigationController.pushViewController(myRecordListViewController, animated: false)
    }
    
    func showMyRecordViewController(cateogryId: Int, categoryName: String) {
        let coordinator = MyRecordCoordinator(navigationController: self.navigationController)
        coordinator.showMyRecordViewController(categoryId: cateogryId, categoryName: categoryName)
        self.childCoordinators.append(coordinator)
    }
    
    func showCategorySettingViewController() {
        let coordinator = CategorySettingCoordinator(navigationController: self.navigationController)
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }
    
    func popViewController() {
        childDidFinish(self)
        navigationController.popViewController(animated: false)
    }
}
