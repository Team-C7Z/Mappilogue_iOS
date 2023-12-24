//
//  SavingRecordCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/24/23.
//

import Foundation

protocol SavingRecordDelegate: AnyObject {
    func showContentViewController()
}

class SavingRecordCoordinator: AppCoordinator, SavingRecordDelegate {
    override func start() {
        let savingRecordViewController = SavingRecordViewController()
        savingRecordViewController.modalPresentationStyle = .overFullScreen
        savingRecordViewController.onSaveComplete = {
            self.showContentViewController()
        }
        navigationController.present(savingRecordViewController, animated: false)
    }
    
    func showContentViewController() {
        let coordinator =
        ContentCoordinator(navigationController: self.navigationController)
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }
}
