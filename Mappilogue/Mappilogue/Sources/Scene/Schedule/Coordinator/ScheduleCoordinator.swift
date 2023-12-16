//
//  ScheduleCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/16/23.
//

import Foundation

protocol ScheduleDelegate: AnyObject {
   // func showNotificationViewController()
}

class ScheduleCoordinator: AppCoordinator, ScheduleDelegate {
    override func start() {
        let addScheduleViewController = AddScheduleViewController()
        addScheduleViewController.hidesBottomBarWhenPushed = true
        addScheduleViewController.coordinator = self
        navigationController.pushViewController(addScheduleViewController, animated: false)
    }
}
