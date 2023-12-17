//
//  NotificationSettingCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/18/23.
//

import Foundation

protocol NotificationSettingDelegate: AnyObject {
    func popViewController()
}

class NotificationSettingCoordinator: BaseCoordinator, NotificationSettingDelegate {
    override func start() {
        let notificationSettingViewController = NotificationSettingViewController()
        notificationSettingViewController.hidesBottomBarWhenPushed = true
        notificationSettingViewController.coordinator = self
        navigationController.pushViewController(notificationSettingViewController, animated: false)
    }
    
    func popViewController() {
        navigationController.popViewController(animated: false)
    }
}
