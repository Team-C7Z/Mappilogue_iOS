//
//  HomeCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/16/23.
//

import UIKit

protocol HomeDelegate: AnyObject {
    func showNotificationViewController()
    func showCalendarDetailViewController()
    func showAddScheduleViewController()
    func showContentViewController()
    func showWriteRecordListViewController()
}

class HomeCoordinator: AppCoordinator, HomeDelegate {
    override func start() {
        let homeViewController = HomeViewController()
        homeViewController.coordinator = self
        navigationController.pushViewController(homeViewController, animated: false)
    }
    
    func showNotificationViewController() {
        let coordinator = NotificationCoordinator(navigationController: self.navigationController)
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }
    
    func showCalendarDetailViewController() {
        let coordinator = CalendarDetailCoordinator(navigationController: self.navigationController)
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }
    
    func showAddScheduleViewController() {
        let coordinator = ScheduleCoordinator(navigationController: self.navigationController)
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }
    
    func showContentViewController() {
        let coordinator = ContentCoordinator(navigationController: self.navigationController)
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }
    
    func showWriteRecordListViewController() {
        let coordinator = WriteRecordListCoordinator(navigationController: self.navigationController)
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }
}
