//
//  MainLocationAlertCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/30/23.
//

import Foundation

protocol MainLocationAlertDelegate: AnyObject {
    func dismissViewController()
}

class MainLocationAlertCoordinator: AppCoordinator, MainLocationAlertDelegate {
    override func start() {
        let mainLocationAlertViewController = MainLocationAlertViewController()
        mainLocationAlertViewController.modalPresentationStyle = .overCurrentContext
        mainLocationAlertViewController.coordinator = self
        navigationController.present(mainLocationAlertViewController, animated: false)
    }
    
    func dismissViewController() {
        navigationController.dismiss(animated: false)
    }
}
