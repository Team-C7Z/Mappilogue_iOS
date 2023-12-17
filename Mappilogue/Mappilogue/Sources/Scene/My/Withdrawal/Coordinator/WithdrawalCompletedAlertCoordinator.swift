//
//  WithdrawalCompletedAlertCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/18/23.
//

import Foundation

protocol WithdrawalCompletedAlertDelegate: AnyObject {
    func popViewController()
}

class WithdrawalCompletedAlertCoordinator: BaseCoordinator, WithdrawalCompletedAlertDelegate {
    
    override func start() {
        let withdrawalCompletedAlertViewController = WithdrawalCompletedAlertViewController()
        withdrawalCompletedAlertViewController.modalPresentationStyle = .overFullScreen
        navigationController.present(withdrawalCompletedAlertViewController, animated: false)
    }
    
    func popViewController() {
        navigationController.popViewController(animated: false)
    }
}
