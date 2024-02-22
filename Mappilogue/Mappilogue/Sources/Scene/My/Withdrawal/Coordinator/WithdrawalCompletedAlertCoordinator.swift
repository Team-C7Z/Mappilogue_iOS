//
//  WithdrawalCompletedAlertCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/18/23.
//

import Foundation

protocol WithdrawalCompletedAlertDelegate: AnyObject {
    func showLoginViewController()
    func popViewController()
}

class WithdrawalCompletedAlertCoordinator: BaseCoordinator, WithdrawalCompletedAlertDelegate {
    override func start() {
        let withdrawalCompletedAlertViewController = WithdrawalCompletedAlertViewController()
        withdrawalCompletedAlertViewController.modalPresentationStyle = .overFullScreen
        withdrawalCompletedAlertViewController.coordinator = self
        navigationController.present(withdrawalCompletedAlertViewController, animated: false)
    }
    
    func showLoginViewController() {
//        let coordinator = LoginCoordinator(navigationController: self.navigationController)
//        coordinator.start()
//        self.childCoordinators.append(coordinator)
    }
    
    func popViewController() {
        navigationController.popViewController(animated: false)
    }
}
