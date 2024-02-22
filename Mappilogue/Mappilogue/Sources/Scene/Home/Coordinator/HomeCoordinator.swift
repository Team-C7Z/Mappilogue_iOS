//
//  HomeCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/16/23.
//

import UIKit

class HomeCoordinator:HomeViewControllerDelegate {
 //   var children: [Coordinator1] = []
    var router: Router
    
    public init(router: Router) {
        self.router = router
    }
    
    func present(animated: Bool, onDismissed: (() -> Void)?) {
//        let viewController = HomeViewController(delegate: self)
//        router.present(viewController, animated: animated, onDismissed: onDismissed)
    }

    func showNotificationViewController() {
//        let coordinator = NotificationCoordinator(navigationController: self.navigationController)
//        coordinator.start()
//        childCoordinators.append(coordinator)
    }
    
    func showCalendarDetailViewController() {
//        let coordinator = CalendarDetailCoordinator(navigationController: self.navigationController)
//        coordinator.start()
//        self.childCoordinators.append(coordinator)
    }
    
    func showAddScheduleViewController() {
//        let coordinator = AddScheduleCoordinator(navigationController: self.navigationController)
//        coordinator.showAddScheduleViewController(scheduleId: nil)
//        self.childCoordinators.append(coordinator)
    }
    
    func showContentViewController() {
//        let coordinator = ContentCoordinator(navigationController: self.navigationController)
//        coordinator.start()
//        self.childCoordinators.append(coordinator)
    }
    
    func showWriteRecordListViewController() {
//        let coordinator = WriteRecordListCoordinator(navigationController: self.navigationController)
//        coordinator.start()
//        self.childCoordinators.append(coordinator)
    }
}
