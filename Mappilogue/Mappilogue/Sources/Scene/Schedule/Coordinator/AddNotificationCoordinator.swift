//
//  AddNotificationCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/25/23.
//

import Foundation

protocol AddNotificationDelegate: AnyObject {
    func popViewController()
}

class AddNotificationCoordinator: AppCoordinator, AddNotificationDelegate {
    override func start() { 
        let addNotificationViewController = AddNotificationViewController()
        addNotificationViewController.coordinator = self
        navigationController.pushViewController(addNotificationViewController, animated: false)
    }
    
    func popViewController() {
        childDidFinish(self)
        navigationController.popViewController(animated: false)
    }
}
