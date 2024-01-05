//
//  AddLocationCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/29/23.
//

import UIKit

protocol AddLocationDelegate: AnyObject {
    func dismissViewController()
}

class AddLocationCoordinator: AppCoordinator, AddLocationDelegate {
    override func start() {
        let addLocationViewController = AddLocationViewController()
        addLocationViewController.modalPresentationStyle = .overFullScreen
        addLocationViewController.coordinator = self
        navigationController.present(addLocationViewController, animated: false)
    }
    
    func dismissViewController() {
        childDidFinish(self)
        navigationController.dismiss(animated: false)
    }
}
