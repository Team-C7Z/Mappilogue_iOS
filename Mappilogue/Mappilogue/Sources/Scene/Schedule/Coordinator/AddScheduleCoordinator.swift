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
    func showScheduleNotificationViewController()
    func showAddLocationViewController()
    func showTimePickerViewController(selectedTime: String)
    func popViewController()
}

class AddScheduleCoordinator: AppCoordinator, AddScheduleDelegate {
    let addScheduleViewController = AddScheduleViewController()
    
    override func start() { }
    
    func showAddScheduleViewController(scheduleId: Int?) {
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
    
    func showScheduleNotificationViewController() {
        let coordinator = ScheduleNotificationCoordinator(navigationController: self.navigationController)
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }
    
    func showAddLocationViewController() {
        let coordinator = AddLocationCoordinator(navigationController: self.navigationController)
        coordinator.delegate = self
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

extension AddScheduleCoordinator: ScheduleLocationDelegate {
    func addLocation(location: KakaoSearchPlaces) {
        addScheduleViewController.addLocation(location)
    }
}
