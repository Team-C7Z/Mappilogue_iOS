//
//  MyCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/16/23.
//

import MappilogueKit

protocol MyDelegate: AnyObject {
    func showEditProfileViewController(_ profile: ProfileDTO?)
    func showNotificationSettingViewController()
}

class MyCoordinator: BaseCoordinator, MyDelegate {
    override func start() {
        let myViewController = MyViewController()
        myViewController.coordinator = self
        navigationController.pushViewController(myViewController, animated: false)
    }
    
    func showNotificationViewController() {
        let coordinator = NotificationCoordinator(navigationController: self.navigationController)
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }
    
    func showEditProfileViewController(_ profile: ProfileDTO?) {
        let coordinator = EditProfileCoordinator(navigationController: navigationController)
        coordinator.showEditProfileViewController(profile)
        childCoordinators.append(coordinator)
    }
    
    func showNotificationSettingViewController() {
        let coordinator = NotificationSettingCoordinator(navigationController: self.navigationController)
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }
    
    func showTermsOfUserViewController() {
        let coordinator = TermsOfUseCoordinator(navigationController: self.navigationController)
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }
    
    func showInquiryViewController() {
        let coordinator = InquiryCoordinator(navigationController: self.navigationController)
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }
    
    func showWithdrawalAlertViewController() {
        let coordinator = WithdrawalAlertCoordinator(navigationController: self.navigationController)
        coordinator.delegate = self
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }
    
    func showWithdrawalViewController() {
        let coordinator = WithdrawalCoordinator(navigationController: self.navigationController)
        coordinator.start()
        coordinator.delegate = self
        self.childCoordinators.append(coordinator)
    }
    
    func showLogoutAlert(alert: Alert) {
        let coordinator = AlertCoordinator(navigationController: self.navigationController)
        coordinator.showAlert(alert)
        self.childCoordinators.append(coordinator)
    }
    
    func showWithdrawalCompletedAlertViewController() {
        let coordinator = WithdrawalCompletedAlertCoordinator(navigationController: self.navigationController)
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }
    
    func showLoginViewController() {
        let coordinator = LoginCoordinator(navigationController: self.navigationController)
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }
}

extension MyCoordinator: WithdrawalButtonDelegate {
    func withdrawalButtonTapped() {
        showWithdrawalViewController()
    }
}

extension MyCoordinator: WithdrawalCompletedDelegate {
    func withdrawal() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.showWithdrawalCompletedAlertViewController()
        }
    }
}
