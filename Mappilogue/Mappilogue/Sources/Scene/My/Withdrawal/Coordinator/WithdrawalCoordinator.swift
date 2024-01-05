//
//  WithdrawalCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/18/23.
//

import Foundation

protocol WithdrawalDelegate: AnyObject {
    func popViewController()
}

protocol WithdrawalCompletedDelegate: AnyObject {
    func withdrawal()
}

class WithdrawalCoordinator: BaseCoordinator, WithdrawalDelegate {
    weak var delegate: WithdrawalCompletedDelegate?
    
    override func start() {
        let withdrawalViewController = WithdrawalViewController()
        withdrawalViewController.hidesBottomBarWhenPushed = true
        withdrawalViewController.coordinator = self
        navigationController.pushViewController(withdrawalViewController, animated: false)
    }
    
    func popViewController() {
        delegate?.withdrawal()
        childDidFinish(self)
        navigationController.popViewController(animated: false)
    }
}
