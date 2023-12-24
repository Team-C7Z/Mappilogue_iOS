//
//  WriteRecordCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/24/23.
//

import Foundation
import Photos

protocol WriteRecordDelegate: AnyObject {
    func showWriteRecordViewController(schedule: Schedule2222)
    func showSelectCategoryViewController()
    func showMainLocationViewController()
    func showImagePickerViewController(authStatus: PHAuthorizationStatus, isProfile: Bool)
    func showSavingRecordViewController()
    func popViewController()
}

class WriteRecordCoordinator: AppCoordinator, WriteRecordListDelegate {
    override func start() { }
    
    func showWriteRecordViewController(schedule: Schedule2222) {
        let writeRecordViewController = WriteRecordViewController()
        writeRecordViewController.coordinator = self
        writeRecordViewController.schedule = schedule
        navigationController.pushViewController(writeRecordViewController, animated: false)
    }
    
    func showSelectCategoryViewController() {
        let coordinator =
        SelectCategoryCoordinator(navigationController: self.navigationController)
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }
    
    func showMainLocationViewController() {
        let coordinator =
        MainLocationCoordinator(navigationController: self.navigationController)
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }
    
    func showImagePickerViewController(authStatus: PHAuthorizationStatus, isProfile: Bool) {
        let coordinator =
        ImagePickerCoordinator(navigationController: self.navigationController)
        coordinator.showImagePickerViewController(authStatus: authStatus, isProfile: isProfile)
        self.childCoordinators.append(coordinator)
    }
    
    func showSavingRecordViewController() {
        let coordinator =
        SavingRecordCoordinator(navigationController: self.navigationController)
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }

    func popViewController() {
        navigationController.popViewController(animated: false)
    }
}
