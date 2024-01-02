//
//  AlertCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/29/23.
//

import MappilogueKit

protocol AlertDelegate: AnyObject {
    func showAlert(_ alert: Alert)
    func dismissAlert()
}

protocol AlertCompletionDelegate: AnyObject {
    func completeAlertAction()
}

class AlertCoordinator: AppCoordinator, AlertDelegate {
    weak var delegate: AlertCompletionDelegate?
    
    override func start() {
        
    }
    
    func showAlert(_ alert: Alert) {
        let alertViewController = AlertViewController()
        alertViewController.modalPresentationStyle = .overCurrentContext
        alertViewController.coordinator = self
        alertViewController.configure(alert)
        alertViewController.onDoneTapped = {
            self.delegate?.completeAlertAction()
        }
        navigationController.present(alertViewController, animated: false)
    }
    
    func dismissAlert() {
        navigationController.dismiss(animated: false)
    }
}
