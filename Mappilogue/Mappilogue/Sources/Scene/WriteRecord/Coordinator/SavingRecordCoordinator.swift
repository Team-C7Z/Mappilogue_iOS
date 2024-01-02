//
//  SavingRecordCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/24/23.
//

import Foundation

protocol SavingRecordDelegate: AnyObject {
    func dismissViewController()
}

class SavingRecordCoordinator: AppCoordinator, SavingRecordDelegate {
    override func start() { }
    
    func showSavingRecordViewController(isNewWrite: Bool, schedule: Schedule2222) {
        let savingRecordViewController = SavingRecordViewController()
        savingRecordViewController.modalPresentationStyle = .overFullScreen
        savingRecordViewController.onSaveComplete = {
            self.showContentViewController(isNewWrite: isNewWrite, schedule: schedule)
        }
        navigationController.present(savingRecordViewController, animated: false)
    }
    
    func showContentViewController(isNewWrite: Bool, schedule: Schedule2222) {
        let coordinator =
        ContentCoordinator(navigationController: navigationController)
        coordinator.start()
        childCoordinators.append(coordinator)
    }
    
    func dismissViewController() {
        navigationController.dismiss(animated: false)
    }
}
