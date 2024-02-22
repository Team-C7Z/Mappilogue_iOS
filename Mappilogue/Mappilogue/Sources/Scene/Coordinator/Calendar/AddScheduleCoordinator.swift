//
//  AddScheduleCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/16/23.
//

import Foundation
import MappilogueKit

class AddScheduleCoordinator {
 //   public var children: [Coordinator1] = []
    public let router: Router
    
    public init(router: Router) {
        self.router = router
    }
    
    func present(animated: Bool, onDismissed: (() -> Void)?) { }
    
    func showAddScheduleViewController(scheduleId: Int?) {
//        let viewController = AddScheduleViewController(delegate: self)
//        viewController.hidesBottomBarWhenPushed = true
//        viewController.viewModel.scheduleId = scheduleId
//        router.present(viewController, animated: true)
    }

    func dismissViewController(_ controller: AddScheduleViewController) {
        print(2)
        router.dismiss(animated: false)
    }
    
    
    
 //   func showAlertViewController(alert: Alert) {
//        let coordinator = AlertCoordinator(navigationController: self.navigationController)
//        coordinator.delegate = self
//        coordinator.showAlert(alert)
//        self.childCoordinators.append(coordinator)
 //   }
    
    func showScheduleNotificationViewController() {
//        let coordinator = ScheduleNotificationCoordinator(navigationController: self.navigationController)
//        coordinator.start()
//        self.childCoordinators.append(coordinator)
    }
    
    func showAddLocationViewController() {
//        let coordinator = AddLocationCoordinator(navigationController: self.navigationController)
//        coordinator.delegate = self
//        coordinator.start()
//        self.childCoordinators.append(coordinator)
    }
    
    func showTimePickerViewController(selectedTime: String) {
//        let coordinator = TimePickerCoordinator(navigationController: self.navigationController)
//        coordinator.showTimePickerViewController(selectedTime)
//        self.childCoordinators.append(coordinator)
    }
    
}

extension AddScheduleCoordinator: ScheduleLocationDelegate {
    func addLocation(location: KakaoSearchPlaces) {
      //  addScheduleViewController.addLocation(location)
    }
}
