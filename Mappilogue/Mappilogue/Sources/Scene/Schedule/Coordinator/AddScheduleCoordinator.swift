//
//  AddScheduleCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/16/23.
//

import Foundation
import MappilogueKit

protocol AddScheduleDelegate: AnyObject {
    func showAlertViewController(alert: Alert)
    func showAddNotificationViewController()
    func showAddLocationViewController()
    func showTimePickerViewController(selectedTime: String)
    func popViewController()
}

class AddScheduleCoordinator: AppCoordinator, AddScheduleDelegate {
    override func start() {
        
    }
    
    func showAddScheduleViewController(scheduleId: Int?) {
        let addScheduleViewController = AddScheduleViewController()
        addScheduleViewController.hidesBottomBarWhenPushed = true
        addScheduleViewController.coordinator = self
        addScheduleViewController.viewModel.scheduleId = scheduleId
        navigationController.pushViewController(addScheduleViewController, animated: false)
    }
    
    func showAlertViewController(alert: Alert) {
        let coordinator = AlertCoordinator(navigationController: self.navigationController)
        coordinator.delegate = self
        coordinator.showAlert(alert)
        self.childCoordinators.append(coordinator)
    }
    
    func showAddNotificationViewController() {
        let coordinator = AddNotificationCoordinator(navigationController: self.navigationController)
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }
    
    func showAddLocationViewController() {
        let coordinator = AddLocationCoordinator(navigationController: self.navigationController)
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }
    
    func showTimePickerViewController(selectedTime: String) {
        let coordinator = TimePickerCoordinator(navigationController: self.navigationController)
        coordinator.showTimePickerViewController(selectedTime)
        self.childCoordinators.append(coordinator)
    }
    
    func popViewController() {
        childDidFinish(self)
        navigationController.popViewController(animated: false)
    }
}

extension AddScheduleCoordinator: AlertCompletionDelegate {
    func completeAlertAction() {
        popViewController()
    }
}
