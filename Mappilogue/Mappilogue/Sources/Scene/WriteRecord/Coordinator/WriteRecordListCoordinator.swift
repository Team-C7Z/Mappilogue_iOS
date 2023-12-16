//
//  WriteRecordListCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/17/23.
//

import Foundation

protocol WriteRecordListDelegate: AnyObject {
    // func showNotificationViewController()
    
}

class WriteRecordListCoordinator: AppCoordinator, WriteRecordListDelegate {
    override func start() {
        let writeRecordListViewController = WriteRecordListRecordViewController()
        writeRecordListViewController.hidesBottomBarWhenPushed = true
        writeRecordListViewController.coordinator = self
        navigationController.pushViewController(writeRecordListViewController, animated: false)
    }
}
