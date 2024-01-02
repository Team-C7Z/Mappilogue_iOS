//
//  CalendarCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/16/23.
//

import Foundation

protocol CalendarDelegate: AnyObject {
    func showDatePickerViewController(date: SelectedDate?)
    func showAddScheduleViewController(scheduleId: Int?)
}

class CalendarCoordinator: BaseCoordinator, CalendarDelegate {
    override func start() {
        let calendarViewController = CalendarViewController()
        calendarViewController.coordinator = self
        navigationController.pushViewController(calendarViewController, animated: false)
    }
    
    func showNotificationViewController() {
        let coordinator = NotificationCoordinator(navigationController: self.navigationController)
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }
    
    func showDatePickerViewController(date: SelectedDate?) {
        let coordinator = DatePickerCoordinator(navigationController: self.navigationController)
        coordinator.showDatePickerViewController(date: date)
        self.childCoordinators.append(coordinator)
    }
    
    func showCalendarDetailViewController(date: String, frame: CGRect) {
        let coordinator = CalendarDetailCoordinator(navigationController: self.navigationController)
        coordinator.showCalendarDetailViewController(date: date, frame: frame)
        self.childCoordinators.append(coordinator)
    }
    
    func showAddScheduleViewController(scheduleId: Int?) {
        let coordinator = AddScheduleCoordinator(navigationController: self.navigationController)
        coordinator.showAddScheduleViewController(scheduleId: scheduleId)
        self.childCoordinators.append(coordinator)
    }
    
    func showWriteRecordViewController(schedule: Schedule2222) {
        let coordinator = WriteRecordCoordinator(navigationController: self.navigationController)
        coordinator.showWriteRecordViewController(schedule: schedule)
        self.childCoordinators.append(coordinator)
    }
}
