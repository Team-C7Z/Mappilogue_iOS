//
//  WithdrawalAlertCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/18/23.
//

import Foundation

protocol WithdrawalAlertDelegate: AnyObject {
    func dismissViewController()
}

protocol WithdrawalButtonDelegate: AnyObject {
    func withdrawalButtonTapped()
}

class WithdrawalAlertCoordinator: BaseCoordinator, WithdrawalAlertDelegate {
    weak var delegate: WithdrawalButtonDelegate?
    
    override func start() {
        let withdrawalAlertViewController = WithdrawalAlertViewController()
        withdrawalAlertViewController.modalPresentationStyle = .overFullScreen
        withdrawalAlertViewController.coordinator = self
        navigationController.present(withdrawalAlertViewController, animated: false)
    }
    
    func withdrawal() {
        delegate?.withdrawalButtonTapped()
        dismissViewController()
    }
    
    func dismissViewController() {
        navigationController.dismiss(animated: false)
    }
}
