//
//  DeleteCategoryAlertCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 1/2/24.
//

import Foundation

protocol DeleteCategoryAlertDelegate: AnyObject {
    func dismissViewController()
}

class DeleteCategoryAlertCoordinator: AppCoordinator, DeleteCategoryAlertDelegate {
    override func start() {
        let alertViewController = DeleteCategoryAlertViewController()
        alertViewController.modalPresentationStyle = .overCurrentContext
        alertViewController.coordinator = self
        navigationController.present(alertViewController, animated: false)
    }
    
    func dismissViewController() {
        navigationController.dismiss(animated: false)
    }
}
