//
//  SelectCategoryCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/24/23.
//

import Foundation

protocol SelectCategoryDelegate: AnyObject {
    func popViewController()
}

class SelectCategoryCoordinator: AppCoordinator, SelectCategoryDelegate {
    override func start() {
        let selectCategoryViewController = SelectCategoryViewController()
        selectCategoryViewController.coordinator = self
        navigationController.pushViewController(selectCategoryViewController, animated: false)
    }
    
    func popViewController() {
        navigationController.popViewController(animated: false)
    }
}
