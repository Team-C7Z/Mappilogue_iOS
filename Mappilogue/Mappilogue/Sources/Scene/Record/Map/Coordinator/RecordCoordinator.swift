//
//  RecordCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/16/23.
//

import Foundation

protocol RecordDelegate: AnyObject {
    func showNotificationController()
    func showSearchViewController()
    func showCategorySettingViewController()
    func showMyRecordListViewController()
    func showWriteRecordViewController()
}

class RecordCoordinator: BaseCoordinator, RecordDelegate {
    override func start() {
        let recordViewController = RecordViewController()
        recordViewController.coordinator = self
        navigationController.pushViewController(recordViewController, animated: false)
    }
    
    func showNotificationController() {
        let coordinator = NotificationCoordinator(navigationController: self.navigationController)
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }
    
    func showSearchViewController() {
        let coordinator = SearchCoordinator(navigationController: self.navigationController)
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }
    
    func showCategorySettingViewController() {
        let coordinator = CategorySettingCoordinator(navigationController: self.navigationController)
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }
    
    func showMyRecordListViewController() {
        let coordinator = MyRecordListCoordinator(navigationController: self.navigationController)
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }
    
    func showWriteRecordViewController() {
        let coordinator = WriteRecordListCoordinator(navigationController: self.navigationController)
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }
}
