//
//  NotificationCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/16/23.
//

import Foundation

protocol NotificationDelegate: AnyObject {
    func popViewController()
}

class NotificationCoordinator: BaseCoordinator, NotificationDelegate {
    override func start() {
        let notificationViewController = NotificationViewController()
        notificationViewController.hidesBottomBarWhenPushed = true
        notificationViewController.coordinator = self
        navigationController.pushViewController(notificationViewController, animated: false)
    }
    
    func popViewController() {
        navigationController.popViewController(animated: true)
    }
}
