//
//  NotificationCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/16/23.
//

import Foundation

class NotificationCoordinator: BaseCoordinator {
    override func start() {
        let notificationViewController = NotificationViewController()
        navigationController.pushViewController(notificationViewController, animated: false)
    }
}
