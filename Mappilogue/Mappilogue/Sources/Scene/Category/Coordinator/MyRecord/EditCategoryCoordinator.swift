//
//  EditCategoryCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/31/23.
//

import Foundation

protocol EditCategoryDelegate: AnyObject {
    func showEditCategoryViewController(categoryId: Int, categoryName: String)
    func showInputModalViewController()
    func dismissViewController()
}

class EditCategoryCoordinator: AppCoordinator, EditCategoryDelegate {
    override func start() { 
        
    }
    
    func showEditCategoryViewController(categoryId: Int, categoryName: String) {
        let editCategoryViewController = EditCategoryViewController()
        editCategoryViewController.modalPresentationStyle = .overFullScreen
        editCategoryViewController.categoryId = categoryId
        editCategoryViewController.categoryName = categoryName
        navigationController.present(editCategoryViewController, animated: false)
    }
    
    func showInputModalViewController() {
        let coordinator = InputModalCoordinator(navigationController: navigationController)
        coordinator.start()
        childCoordinators.append(coordinator)
    }
    
    func showDeleatCategoryAlert() {
        
    }
    
    func dismissViewController() {
        childDidFinish(self)
        navigationController.dismiss(animated: false)
    }
}
