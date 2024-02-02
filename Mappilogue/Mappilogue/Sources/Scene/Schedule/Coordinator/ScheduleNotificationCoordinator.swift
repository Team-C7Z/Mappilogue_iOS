//
//  AddNotificationCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/25/23.
//

import Foundation

protocol ScheduleNotificationDelegate: AnyObject {
    func popViewController()
}

class ScheduleNotificationCoordinator: AppCoordinator, ScheduleNotificationDelegate {
    override func start() { 
        let addNotificationViewController = ScheduleNotificationViewController()
        addNotificationViewController.coordinator = self
        navigationController.pushViewController(addNotificationViewController, animated: false)
    }
    
    func popViewController() {
        childDidFinish(self)
        navigationController.popViewController(animated: false)
    }
}
