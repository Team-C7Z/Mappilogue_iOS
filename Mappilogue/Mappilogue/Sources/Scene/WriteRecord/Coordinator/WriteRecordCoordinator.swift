//
//  WriteRecordCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/24/23.
//

import MappilogueKit
import Photos

protocol WriteRecordDelegate: AnyObject {
    func showWriteRecordViewController(schedule: Schedule2222)
    func showSelectCategoryViewController()
    func showMainLocationViewController()
    func showImagePickerViewController(authStatus: PHAuthorizationStatus, isProfile: Bool)
    func showSavingRecordViewController()
    func popViewController()
}

class WriteRecordCoordinator: WriteRecordListDelegate {
    func start() { }
    
    func showWriteRecordViewController(schedule: Schedule2222) {
//        let writeRecordViewController = WriteRecordViewController()
//        writeRecordViewController.coordinator = self
//        writeRecordViewController.schedule = schedule
//        navigationController.pushViewController(writeRecordViewController, animated: false)
    }
    
    func showAlertViewController(alert: Alert) {
   //     let coordinator =
   //     AlertCoordinator(navigationController: self.navigationController)
    //    coordinator.showAlert(alert)
     //   self.childCoordinators.append(coordinator)
    }
    
    func showSelectCategoryViewController() {
//        let coordinator =
//        SelectCategoryCoordinator(navigationController: self.navigationController)
//        coordinator.start()
//        self.childCoordinators.append(coordinator)
    }
    
    func showMainLocationViewController() {
//        let coordinator =
//        MainLocationCoordinator(navigationController: self.navigationController)
//        coordinator.start()
//        self.childCoordinators.append(coordinator)
    }
    
    func showGalleyPermissionAlertViewController(alert: Alert) {
    //    let coordinator =
    //    AlertCoordinator(navigationController: self.navigationController)
    //    coordinator.showAlert(alert)
    //    self.childCoordinators.append(coordinator)
    }
    
    func showImagePickerViewController(authStatus: PHAuthorizationStatus, isProfile: Bool) {
//        let coordinator =
//        ImagePickerCoordinator(navigationController: self.navigationController)
//        coordinator.showImagePickerViewController(authStatus: authStatus, isProfile: isProfile)
//        self.childCoordinators.append(coordinator)
    }
    
    func showSavingRecordViewController(isNewWrite: Bool, schedule: Schedule2222) {
//        let coordinator =
//        SavingRecordCoordinator(navigationController: self.navigationController)
//        coordinator.showSavingRecordViewController(isNewWrite: isNewWrite, schedule: schedule)
//        self.childCoordinators.append(coordinator)
    }

    func popViewController() {
//        childDidFinish(self)
//        navigationController.popViewController(animated: false)
    }
}
