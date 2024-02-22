//
//  WriteRecordListCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/17/23.
//

import Foundation

protocol WriteRecordListDelegate: AnyObject {
    func popViewController()
    func showWriteRecordViewController(schedule: Schedule2222)
}

class WriteRecordListCoordinator {
//    override func start() {
//        let writeRecordListViewController = WriteRecordListRecordViewController()
//        writeRecordListViewController.hidesBottomBarWhenPushed = true
//        writeRecordListViewController.coordinator = self
//        navigationController.pushViewController(writeRecordListViewController, animated: false)
//    }
//    
//    func showWriteRecordViewController(schedule: Schedule2222) {
//        let coordinator =
//        WriteRecordCoordinator(navigationController: self.navigationController)
//        coordinator.showWriteRecordViewController(schedule: schedule)
//        self.childCoordinators.append(coordinator)
//    }
//    
//    func popViewController() {
//        childDidFinish(self)
//        navigationController.popViewController(animated: false)
//    }
}
